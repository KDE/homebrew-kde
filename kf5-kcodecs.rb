require "formula"

class Kf5Kcodecs < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kcodecs-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/kcodecs.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end
