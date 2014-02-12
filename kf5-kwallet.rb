require "formula"

class Kf5Kwallet < Formula
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwallet.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-knotifications"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kauth"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/src/api/KWallet/CMakeLists.txt b/src/api/KWallet/CMakeLists.txt
index a55a8b8..2458848 100644
--- a/src/api/KWallet/CMakeLists.txt
+++ b/src/api/KWallet/CMakeLists.txt
@@ -18,7 +18,7 @@ ecm_setup_version(${KF5_VERSION} VARIABLE_PREFIX KWALLET
                         PACKAGE_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/KF5WalletConfigVersion.cmake")
 
 if (APPLE)
-   find_package(Carbon REQUIRED)
+#   find_package(Carbon REQUIRED)
 endif ()
 
 remove_definitions(-DQT_NO_CAST_TO_ASCII)
@@ -86,7 +86,8 @@ add_library(KF5::Wallet ALIAS KF5Wallet)
 target_include_directories(KF5Wallet INTERFACE "$<INSTALL_INTERFACE:${INCLUDE_INSTALL_DIR}/KWallet>")
 
 target_link_libraries(KF5Wallet PUBLIC  Qt5::Widgets
-                                PRIVATE KF5::WindowSystem # KWindowSystem::allowExternalProcessWindowActivation
+                                PRIVATE Qt5::DBus
+					KF5::WindowSystem # KWindowSystem::allowExternalProcessWindowActivation
                                         KF5::ConfigCore   # used to store the wallet to be used
 )
 
