class Kf5Kdelibs4support < Formula
  desc "Porting aid from KDELibs4"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/portingAids/kdelibs4support-5.57.0.tar.xz"
  sha256 "e9d1c06191031b482ea01d891756d125ff32927239c36a3011fc7b8f17aca1b0"

  head "git://anongit.kde.org/kdelibs4support.git"
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdesignerplugin" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "perl" => :build

  depends_on "KDE-mac/kde/kf5-kded"
  depends_on "KDE-mac/kde/kf5-kemoticons"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kunitconversion"
  depends_on "openssl"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kdebugdialog5.app/Contents/Info.plist"
  end

  def caveats; <<~EOS
    Before install of this formula you need to run:
      brew install perl
      export PERL_MM_USE_DEFAULT=1
      cpan URI URI::Escape

    You need to take some manual steps in order to make this formula work:
      ln -sfv "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
      ln -sfv "$(brew --prefix)/share/kservices5" "$HOME/Library/Application Support"
      mkdir -pv "$HOME/Applications/KDE"
      ln -sfv "$(brew --prefix)/opt/kf5-kdelibs4support/bin/kdebugdialog5.app" "$HOME/Applications/KDE/"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KDELibs4Support)")
    system bin/"cmake", "."
  end
end

# Patch based from
# https://github.com/KDE/kdoctools/blob/master/cmake/FindDocBookXML4.cmake

__END__
diff --git a/cmake/FindDocBookXML4.cmake b/cmake/FindDocBookXML4.cmake
index dcc0cf66..6fbf4ebb 100644
--- a/cmake/FindDocBookXML4.cmake
+++ b/cmake/FindDocBookXML4.cmake
@@ -11,8 +11,29 @@
 
 # Copyright (c) 2010, 2014 Luigi Toscano, <luigi.toscano@tiscali.it>
 #
-# Redistribution and use is allowed according to the terms of the BSD license.
-# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+# 3. Neither the name of the University nor the names of its contributors
+#    may be used to endorse or promote products derived from this software
+#    without specific prior written permission.
+#
+# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+# ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+# SUCH DAMAGE.
 
 
 if (NOT DocBookXML_FIND_VERSION)
@@ -30,10 +51,12 @@ set_package_properties(DocBookXML4 PROPERTIES DESCRIPTION "DocBook XML 4"
 function (locate_version version found_dir)
 
     set (DTD_PATH_LIST
-        share/xml/docbook/schema/dtd/${version}
-        share/xml/docbook/xml-dtd-${version}
-        share/sgml/docbook/xml-dtd-${version}
-        share/xml/docbook/${version}
+        ${CMAKE_INSTALL_DATAROOTDIR}/xml/docbook/schema/dtd/${version}
+        ${CMAKE_INSTALL_DATAROOTDIR}/xml/docbook/xml-dtd-${version}
+        ${CMAKE_INSTALL_DATAROOTDIR}/sgml/docbook/xml-dtd-${version}
+        ${CMAKE_INSTALL_DATAROOTDIR}/xml/docbook/${version}
+        #for building on Mac with docbook installed by homebrew
+        opt/docbook/docbook/xml/${version}
     )
 
     find_path (searched_dir docbookx.dtd
