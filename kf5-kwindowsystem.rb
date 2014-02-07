require "formula"

class Kf5Kwindowsystem < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kwindowsystem-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kwindowsystem.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE -DQT_MAC_USE_COCOA'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6cebf0c..127d3cd 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -11,6 +11,7 @@ include(GenerateExportHeader)
 include(CMakePackageConfigHelpers)
 include(ECMSetupVersion)
 include(ECMGenerateHeaders)
+include(CMakeFindFrameworks)
 
 set(KF5_VERSION "4.96.0")
 
@@ -26,19 +27,23 @@ include(KDEInstallDirs)
 include(KDEFrameworkCompilerSettings)
 include(KDECMakeSettings)
 
-if(NOT WIN32)
+if(NOT WIN32 AND NOT APPLE)
     find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED X11Extras)
 endif()
 
 if (APPLE)
-   find_package(Carbon REQUIRED)
-endif ()
+    cmake_find_frameworks(Carbon)
+    cmake_find_frameworks(CoreFoundation)
+endif()
 
 if(WIN32)
    find_package(Qt5WinExtras REQUIRED)
 endif()
 
-find_package(X11)
+if (NOT APPLE)
+    find_package(X11)
+endif()
+
 set(KWINDOWSYSTEM_HAVE_X11 ${X11_FOUND})
 find_package(XCB COMPONENTS XCB KEYSYMS)
 if(X11_FOUND)
diff --git a/autotests/CMakeLists.txt b/autotests/CMakeLists.txt
index 144986f..073b6dd 100644
--- a/autotests/CMakeLists.txt
+++ b/autotests/CMakeLists.txt
@@ -5,8 +5,11 @@ remove_definitions(-DQT_NO_CAST_TO_ASCII)
 include(ECMMarkAsTest)
 
 find_package(Qt5 5.2.0 CONFIG REQUIRED Test)
-find_package(X11)
-find_package(XCB COMPONENTS XCB)
+
+if (NOT APPLE)
+    find_package(X11)
+    find_package(XCB COMPONENTS XCB)
+endif()
 
 macro(KWINDOWSYSTEM_UNIT_TESTS)
    foreach(_testname ${ARGN})
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 9c1d452..5dba0d6 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -39,6 +39,7 @@ if (APPLE)
 # FIXME: adjust kwindowinfo_mac to inherit from KWindowInfoPrivate
 #                                                 kwindowinfo_mac.cpp
 )
+  set(platformLinkLibraries "-framework CoreFoundation -framework Carbon")
 endif ()
 
 if (WIN32)
