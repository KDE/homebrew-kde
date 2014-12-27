require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kapidox-5.5.0.tar.xz"
  sha1 "535c5b407c36dfa647404cb0ef3d0e60dc247861"
  homepage "http://www.kde.org/"

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
