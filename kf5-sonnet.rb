require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.7/sonnet-5.7.0.tar.xz"
  sha1 "06da89b3a1553bd1fe9083141ab4c08a34b30c22"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
