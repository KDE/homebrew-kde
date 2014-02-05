require "formula"

class Kcrash < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kcrash-4.95.0.tar.xz"
  sha1 ""

  head 'git://anongit.kde.org/kcrash.git'

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "qt5"
  #depends_on "kwindowsystem"

  def patches
    DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4f56afc..3046c38 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -26,7 +26,7 @@ ecm_setup_version(${KF5_VERSION} VARIABLE_PREFIX KCrash
 
 if(NOT kdelibs_SOURCE_DIR)
   find_package(KF5CoreAddons ${KF5_VERSION} REQUIRED)
-  find_package(KF5WindowSystem ${KF5_VERSION} REQUIRED)
+  #find_package(KF5WindowSystem ${KF5_VERSION} REQUIRED)
 endif()
 
 add_subdirectory(src)
diff --git a/KF5CrashConfig.cmake.in b/KF5CrashConfig.cmake.in
index dcde843..ddb4b30 100644
--- a/KF5CrashConfig.cmake.in
+++ b/KF5CrashConfig.cmake.in
@@ -3,7 +3,7 @@
 # Any changes in this file will be overwritten by CMake.
 
 find_dependency(KF5CoreAddons "@KF5_VERSION@")
-find_dependency(KF5WindowSystem "@KF5_VERSION@")
+#find_dependency(KF5WindowSystem "@KF5_VERSION@")
 
 find_dependency(Qt5Core @REQUIRED_QT_VERSION@)
 
diff --git a/autotests/test_crasher.cpp b/autotests/test_crasher.cpp
index 75ac7c6..1e918ae 100644
--- a/autotests/test_crasher.cpp
+++ b/autotests/test_crasher.cpp
@@ -25,6 +25,8 @@
 #include <sys/resource.h> // setrlimit
 #endif
 
+#include <errno.h>
+
 QFile output;
 
 void saveFunction(int)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index ddf0fab..30d6e34 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -28,7 +28,8 @@ add_library(KF5::Crash ALIAS KF5Crash)
 target_include_directories(KF5Crash INTERFACE "$<INSTALL_INTERFACE:${INCLUDE_INSTALL_DIR}/KCrash>")
 
 target_link_libraries(KF5Crash PUBLIC Qt5::Core)
-target_link_libraries(KF5Crash PRIVATE KF5::CoreAddons KF5::WindowSystem)
+#target_link_libraries(KF5Crash PRIVATE KF5::CoreAddons KF5::WindowSystem)
+target_link_libraries(KF5Crash PRIVATE KF5::CoreAddons)
 
 
 if(${X11_FOUND})
diff --git a/src/kcrash.cpp b/src/kcrash.cpp
index c3a234a..ddd6d81 100644
--- a/src/kcrash.cpp
+++ b/src/kcrash.cpp
@@ -44,7 +44,7 @@
 #endif
 
 #include <kaboutdata.h>
-#include <kstartupinfo.h>
+//#include <kstartupinfo.h>
 
 #include <QDebug>
 #include <QCoreApplication>
@@ -58,6 +58,8 @@
 #include <X11/Xlib.h>
 #endif
 
+#include <errno.h>
+
 #ifdef Q_OS_SOLARIS
 // Solaris has built-in, thread-safe, async-signal-safe, mechanisms
 // to walk the stack in the case of a crash, as well as (optionally)
@@ -462,12 +464,14 @@ KCrash::defaultCrashHandler(int sig)
             }
         }
 
+#if 0
         char sidtxt[256];
         if (!KStartupInfo::startupId().isNull()) {
             argv[i++] = "--startupid";
             strlcpy(sidtxt, KStartupInfo::startupId().constData(), sizeof(sidtxt));
             argv[i++] = sidtxt;
         }
+#endif
 
         if (s_flags & SaferDialog) {
             argv[i++] = "--safer";
