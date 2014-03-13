require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kidletime-4.97.0.tar.xz"
  sha1 "365535853c21ab27f093a133d763d5e372d4b778"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kidletime.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def patches
    if not build.head?
      DATA
    end
  end

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 03136ea..d44cd34 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -7,6 +7,7 @@ find_package(ECM 0.0.11 REQUIRED NO_MODULE)
 set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
 
 include(FeatureSummary)
+include(CMakeFindFrameworks)
 include(GenerateExportHeader)
 include(ECMPackageConfigHelpers)
 include(ECMSetupVersion)
@@ -27,16 +28,19 @@ include(KDECMakeSettings)
 set(REQUIRED_QT_VERSION 5.2.0)
 find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED Widgets)
 
-if(NOT WIN32)
+if(NOT WIN32 AND NOT APPLE)
     find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED X11Extras DBus)
 endif()
 
-if (APPLE)
-   find_package(Carbon REQUIRED)
-endif ()
+if(APPLE)
+    cmake_find_frameworks(CoreFoundation Carbon)
+endif()
+
+if(NOT APPLE)
+    find_package(X11)
+    find_package(XCB COMPONENTS XCB)
+endif()
 
-find_package(X11)
-find_package(XCB COMPONENTS XCB)
 if(X11_FOUND)
     find_package(XCB COMPONENTS XCB SYNC)
     find_package(X11_XCB)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index ac1698f..b6b1629 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -27,6 +27,7 @@ if (X11_FOUND)
    set(kidletime_LIBS ${kidletime_LIBS} ${X11_LIBRARIES} Qt5::X11Extras)
 elseif (APPLE)
    set(kidletime_LIB_SRCS ${kidletime_LIB_SRCS} macpoller.cpp)
+   set(kidletime_LIBS "-framework CoreFoundation -framework Carbon")
 elseif (WIN32)
    set(kidletime_LIB_SRCS ${kidletime_LIB_SRCS} windowspoller.cpp)
 endif ()
