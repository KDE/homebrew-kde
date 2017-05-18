require "formula"

class Kf5Kdnssd < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kdnssd-5.34.0.tar.xz"
  sha256 "0029e90f01dc8a7e751d96a11ba6ce6ae541c8f4cac9eac8556d7a9e6a6c5520"

  head "git://anongit.kde.org/attica.git"

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
