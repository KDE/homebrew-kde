require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kdesu-4.98.0.tar.xz"
  sha1 "7e500f742b1444d8002003d92238a5c0746a56ee"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  patch :DATA unless build.head?

  def install
    args = std_cmake_args
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
diff --git a/src/kdesud/CMakeLists.txt b/src/kdesud/CMakeLists.txt
index 3094e27..9004f83 100644
--- a/src/kdesud/CMakeLists.txt
+++ b/src/kdesud/CMakeLists.txt
@@ -1,3 +1,4 @@
+include(CheckFunctionExists)
 check_function_exists(getpeereid HAVE_GETPEEREID) # openbsd style
 check_function_exists(getpeereucred HAVE_GETPEERUCRED) # solaris style
