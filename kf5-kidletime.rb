require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kidletime-5.36.0.tar.xz"
  sha256 "34315b6174e69fa371c3f4236c4de9e14eab46e2464c48c1be252a27b4fa1ab6"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kidletime.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
