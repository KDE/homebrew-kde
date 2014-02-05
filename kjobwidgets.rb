require "formula"

class Kjobwidgets < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kjobwidgets-4.95.0.tar.xz"
  sha1 "2d2c66e7f84dc5a180945150c90ae6e08cb78e98"

  head 'git://anongit.kde.org/kjobwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kcoreaddons"
  depends_on "haraldf/kf5/kwidgetsaddons"
  depends_on "qt5"

  def patches
      DATA
  end

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index a387fcd..3d642e6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -15,8 +15,10 @@ set(KF5_VERSION "5.0.0")
 set(QT_REQUIRED_VERSION 5.2.0)
 find_package(Qt5 ${QT_REQUIRED_VERSION} CONFIG REQUIRED Widgets DBus)
 
-find_package(X11)
-set(HAVE_X11 ${X11_FOUND})
+if (NOT APPLE)
+    find_package(X11)
+    set(HAVE_X11 ${X11_FOUND})
+endif()
 
 if("${CMAKE_BINARY_DIR}" STREQUAL "${CMAKE_CURRENT_BINARY_DIR}")
     find_package(KF5CoreAddons ${KF5_VERSION} REQUIRED)
