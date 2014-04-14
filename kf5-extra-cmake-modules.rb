require "formula"

class Kf5ExtraCmakeModules < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.98.0/extra-cmake-modules-0.0.12.tar.xz"
  sha1 "98a25e3b0b68171f55fa18fb16df5e002d59cb7c"

  keg_only "Only required for building KDE frameworks"

  head 'git://anongit.kde.org/extra-cmake-modules'

  depends_on "cmake" => :build

  def patches
    DATA
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/kde-modules/KDEInstallDirs.cmake b/kde-modules/KDEInstallDirs.cmake
index 9ff2354..054e697 100644
--- a/kde-modules/KDEInstallDirs.cmake
+++ b/kde-modules/KDEInstallDirs.cmake
@@ -143,7 +143,11 @@ _set_fancy(PLUGIN_INSTALL_DIR        "${QT_PLUGIN_INSTALL_DIR}/kf5"
 _set_fancy(IMPORTS_INSTALL_DIR       "${QT_PLUGIN_INSTALL_DIR}/imports"            "The install dir where QtQuick1 imports will be installed")
 _set_fancy(QML_INSTALL_DIR           "${LIB_INSTALL_DIR}/qml"                      "The install dir where QtQuick2 imports will be installed")
 _set_fancy(CMAKECONFIG_INSTALL_PREFIX "${LIB_INSTALL_DIR}/cmake"                   "The prefix under which packages will create their own subdirectory for their CMake configuration files")
+if (APPLE)
+_set_fancy(DATA_INSTALL_DIR          "$ENV{HOME}/Library/Application Support"                     "The parent directory where applications can install their data")
+else()
 _set_fancy(DATA_INSTALL_DIR          "${SHARE_INSTALL_PREFIX}"                     "The parent directory where applications can install their data")
+endif()
 _set_fancy(HTML_INSTALL_DIR          "${SHARE_INSTALL_PREFIX}/doc/HTML"            "The HTML install dir for documentation")
 _set_fancy(ICON_INSTALL_DIR          "${SHARE_INSTALL_PREFIX}/icons"               "The icon install dir (default ${SHARE_INSTALL_PREFIX}/share/icons/)")
 _set_fancy(KCFG_INSTALL_DIR          "${SHARE_INSTALL_PREFIX}/config.kcfg"         "The install dir for kconfig files")
