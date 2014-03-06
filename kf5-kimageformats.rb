require "formula"

class Kf5Kimageformats < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kimageformats-4.97.0.tar.xz"
  sha1 "bcc8ff9d2714f794c697687a792d8b0d98483a8c"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kimageformats.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end
