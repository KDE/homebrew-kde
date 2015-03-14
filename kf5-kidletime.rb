require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.8/kidletime-5.8.0.tar.xz"
  sha1 "5b6132d778a9e265cafc8e402a368157a4ba7476"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kidletime.git'

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
