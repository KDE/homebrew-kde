class Kf5Kcoreaddons < Formula
  desc "Addons to QtCore"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.42/kcoreaddons-5.42.0.tar.xz"
  sha256 "4967aba9f0175025a1c076cf15487d10ce08d27cad740f814ab58af34d3e1b9f"
  revision 1

  head "git://anongit.kde.org/kcoreaddons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "shared-mime-info" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  patch :DATA

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
  end

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
    EOS
  end
end

__END__
--- a/src/mimetypes/CMakeLists.txt      2017-10-29 05:46:14.027699012 +0100
+++ b/src/mimetypes/CMakeLists.txt      2017-10-07 21:09:54.000000000 +0200
@@ -9,6 +9,8 @@
                       )

 # update XDG mime-types if shared mime info is around
-if(SharedMimeInfo_FOUND)
-    update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
-endif()
+
+# Need generate out of brew by update-mime-database
+#if(SharedMimeInfo_FOUND)
+#    update_xdg_mimetypes(${KDE_INSTALL_MIMEDIR})
+#endif()
