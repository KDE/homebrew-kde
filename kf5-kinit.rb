require "formula"

class Kf5Kinit < Formula
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kinit.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

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
index 30a9fe1..5fa97f3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -25,7 +25,9 @@ ecm_setup_version(${KF5_VERSION} VARIABLE_PREFIX KINIT
 include(ConfigureChecks.cmake)
 
 #optional features
-find_package(X11)
+if (NOT APPLE)
+    find_package(X11)
+endif()
 set(HAVE_X11 ${X11_FOUND})
 
 # used by 4 executables in this module
