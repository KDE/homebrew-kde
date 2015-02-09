require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.6/kidletime-5.6.0.tar.xz"
  sha1 "7dce0b7c7129d146d9447812d3331bfdf50ae916"
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
