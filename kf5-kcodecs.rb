require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kcodecs-5.10.0.tar.xz"
  sha1 "7fd9352b1a434077ca2cd537c9d5de19f4f9824c"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcodecs.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
