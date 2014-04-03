require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/karchive-4.97.0.tar.xz"
  sha1 "6f5f95e3beb4f05600d8b892adf602f7651d6064"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/karchive.git'

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
