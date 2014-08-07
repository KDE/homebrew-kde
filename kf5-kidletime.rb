require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.1.0/kidletime-5.1.0.tar.xz"
  sha1 "610813cbcc10be581a9855181e22f094a4834da9"
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
