require "formula"

class Kf5Kio < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kio-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kio.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-kjobwidgets"

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
