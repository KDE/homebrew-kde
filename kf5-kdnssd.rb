require "formula"

class Kf5Kdnssd < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kdnssd-5.5.0.tar.xz"
  sha1 "8109c862208c4f33dc2ae80210a6c0e088c41fb6"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

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
