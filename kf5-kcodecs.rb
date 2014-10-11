require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kcodecs-5.3.0.tar.xz"
  sha1 "b0ae874d193605f28b069a9b54926ca14a780ce5"
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
