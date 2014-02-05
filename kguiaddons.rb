require "formula"

class Kguiaddons < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kguiaddons-4.95.0.tar.xz"
  sha1 "8e9689f3bb978194788d0801325b2a4045cfd9d4"

  head 'git://anongit.kde.org/kguiaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
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
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index b0520d8..15cff66 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -14,7 +14,7 @@ set(kguiaddons_LIB_SRCS
  util/urlhandler.cpp
 )
 
-if (X11_FOUND AND X11_Xkb_FOUND AND XCB_XCB_FOUND)
+if (NOT APPLE AND X11_FOUND AND X11_Xkb_FOUND AND XCB_XCB_FOUND)
     include_directories (
         ${X11_Xkb_INCLUDE_PATH}
         ${X11_Xlib_INCLUDE_PATH}
