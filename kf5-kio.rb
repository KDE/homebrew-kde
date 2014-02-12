require "formula"

class Kf5Kio < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kio-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kio.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-kjobwidgets"
  depends_on "haraldf/kf5/kf5-knotifications"

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
index 0e67517..8eaae80 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -43,7 +43,7 @@ if("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
   find_package(KF5WindowSystem ${KF5_VERSION} REQUIRED)
   find_package(KF5Crash ${KF5_VERSION} REQUIRED)
   find_package(KF5Completion ${KF5_VERSION} REQUIRED)
-  find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
+#  find_package(KF5DocTools ${KF5_VERSION} REQUIRED)
   find_package(KF5TextWidgets ${KF5_VERSION} REQUIRED)
   find_package(KF5XmlGui ${KF5_VERSION} REQUIRED)
   find_package(KF5Bookmarks ${KF5_VERSION} REQUIRED)
@@ -73,7 +73,7 @@ set_package_properties(GSSAPI PROPERTIES DESCRIPTION "Allows KIO to make use of
 find_package(X11)
 set(HAVE_X11 ${X11_FOUND})
 
-add_subdirectory(docs)
+#add_subdirectory(docs)
 include(CheckLibraryExists)
 add_subdirectory(src)
 add_subdirectory(autotests)
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 2106e1f..1b5fa82 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -55,7 +55,7 @@ add_subdirectory(ioslaves)
 add_subdirectory(kssld)
 add_subdirectory(kioslave)
 
-if(NOT WIN32)
+if(NOT WIN32 AND NOT APPLE)
   # arpa/nameser.h
   add_subdirectory(kpac)
 endif()
diff --git a/src/core/kmountpoint.cpp b/src/core/kmountpoint.cpp
index cc69957..3d568f8 100644
--- a/src/core/kmountpoint.cpp
+++ b/src/core/kmountpoint.cpp
@@ -51,6 +51,12 @@ static Qt::CaseSensitivity cs = Qt::CaseSensitive;
 #include <sys/mntent.h>
 #endif
 
+#ifdef Q_OS_MAC
+#  define HAVE_SYS_MOUNT_H 1
+#  define HAVE_SYS_TYPES_H 1
+#  define HAVE_SYS_PARAM_H 1
+#endif
+
 // This is the *BSD branch
 #if HAVE_SYS_MOUNT_H
 #if HAVE_SYS_TYPES_H
diff --git a/src/ioslaves/CMakeLists.txt b/src/ioslaves/CMakeLists.txt
index 6436b12..b848c66 100644
--- a/src/ioslaves/CMakeLists.txt
+++ b/src/ioslaves/CMakeLists.txt
@@ -1,6 +1,6 @@
 
 add_subdirectory( file )
-add_subdirectory( help )
+#add_subdirectory( help )
 add_subdirectory( http )
 add_subdirectory( ftp )
 add_subdirectory( mailto )
