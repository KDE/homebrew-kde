require_relative "../lib/cmake"

class Kf5Kdelibs4support < Formula
  desc "Porting aid from KDELibs4"
  homepage "https://api.kde.org/frameworks/kdelibs4support/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/portingAids/kdelibs4support-5.79.0.tar.xz"
  sha256 "a542e75e0b20325e5a88d33229441416da4c8d467742a229b2aa87e368053411"
  head "https://invent.kde.org/frameworks/kdelibs4support.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "kde-kdoctools" => :build
  depends_on "kde-mac/kde/kf5-kdesignerplugin" => :build
  depends_on "ninja" => :build
  depends_on "perl" => :build

  depends_on "kde-mac/kde/kf5-kded"
  depends_on "kde-mac/kde/kf5-kemoticons"
  depends_on "kde-mac/kde/kf5-kitemmodels"
  depends_on "kde-mac/kde/kf5-kparts"
  depends_on "kde-mac/kde/kf5-kunitconversion"
  depends_on "openssl"

  patch :DATA

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kdebugdialog5.app/Contents/Info.plist"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KF5KDELibs4Support REQUIRED)
      find_package(KF5KDE4Support REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
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
