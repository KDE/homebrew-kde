require "formula"

class Kf5Kde4support < Formula
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kde4support.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kunitconversion"
  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kbookmarks"
  depends_on "haraldf/kf5/kf5-kio"
#  depends_on "haraldf/kf5/kf5-kdoctools"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-knotifications"
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "haraldf/kf5/kf5-kdesignerplugin"
  depends_on "haraldf/kf5/kf5-kglobalaccel"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index a32b6f4..3eb3086 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -11,12 +11,13 @@ include(KDEFrameworkCompilerSettings)
 include(KDECMakeSettings)
 include(FeatureSummary)
 include(GenerateExportHeader)
+include(CMakeFindFrameworks)
 
 set(KF5_VERSION "4.96.0")
 set(QT_REQUIRED_VERSION 5.2.0)
 find_package(Qt5 ${QT_REQUIRED_VERSION} CONFIG REQUIRED Network Widgets DBus Test Svg Concurrent PrintSupport Designer)
 
-if(NOT WIN32)
+if(NOT WIN32 AND NOT APPLE)
     find_package(Qt5 ${QT_REQUIRED_VERSION} CONFIG REQUIRED X11Extras)
 endif()
 
@@ -38,7 +39,7 @@ if("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
     find_package(KF5XmlGui ${KF5_VERSION} REQUIRED)
     find_package(KF5Bookmarks ${KF5_VERSION} REQUIRED)
     find_package(KF5KIO ${KF5_VERSION} REQUIRED)
-    find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
+#    find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
     find_package(KF5Crash ${KF5_VERSION} REQUIRED)
     find_package(KF5Notifications ${KF5_VERSION} REQUIRED)
     find_package(KF5Parts ${KF5_VERSION} REQUIRED)
@@ -52,13 +53,15 @@ else()
     include(${CMAKE_SOURCE_DIR}/tier3/kdesignerplugin/KF5DesignerPluginMacros.cmake)
 endif()
 
-find_package(X11)
+if (NOT APPLE)
+    find_package(X11)
+endif()
 set(HAVE_X11 ${X11_FOUND})
 if (HAVE_X11)
   add_feature_info("X11 Session Management (libSM)" X11_SM_FOUND "Support for session management in KApplication")
 endif ()
 if (APPLE)
-   find_package(Carbon REQUIRED)
+    cmake_find_frameworks(CoreFoundation)
 endif ()
 
 include(ECMSetupVersion)
diff --git a/docs/CMakeLists.txt b/docs/CMakeLists.txt
index 1664a86..9ab44f5 100644
--- a/docs/CMakeLists.txt
+++ b/docs/CMakeLists.txt
@@ -1 +1 @@
-add_subdirectory(kf5-config)
+#add_subdirectory(kf5-config)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 3f4a131..938021d 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -275,6 +275,11 @@ target_include_directories(KF5KDE4Support PUBLIC "$<BUILD_INTERFACE:${kde4suppor
 
 target_include_directories(KF5KDE4Support INTERFACE "$<INSTALL_INTERFACE:${INCLUDE_INSTALL_DIR}/KDE4Support>" "$<INSTALL_INTERFACE:${INCLUDE_INSTALL_DIR}/KDE4Support/KDE>")
 
+set(platformLinkLibraries)
+if (APPLE)
+    set(platformLinkLibraries "-framework CoreFoundation -framework Carbon -lresolv")
+endif()
+
 target_link_libraries(KF5KDE4Support
 PUBLIC
    Qt5::Widgets
@@ -304,8 +309,10 @@ PRIVATE
    Qt5::Test # for qtest_kde.cpp
    ${KIO_EXTRA_LIBS}
    ${libkde4support_OPTIONAL_LIBS}
+   ${platformLinkLibraries}
 )
 
+
 # This flag is needed in order to be able to support files > 2GB even on
 # 32bit platforms. The default is to use the non-64bit aware syscalls on
 # 32bit platforms, which makes every application to SIGXFSZ (which is
