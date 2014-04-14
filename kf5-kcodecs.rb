require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kcodecs-4.98.0.tar.xz"
  sha1 "139ea3ce5f87d47e7991cf8950a6dd7b50907027"
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
