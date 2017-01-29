require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kapidox-5.30.0.tar.xz"
  sha256 "4edae3b3a3d2ede9567533174bb33dd66bde9228c98f4af4f36431c45f5d1723"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kapidox.git'

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
