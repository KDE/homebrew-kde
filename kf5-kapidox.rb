require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kapidox-5.10.0.tar.xz"
  sha1 "12d033918357d410c7565661d617fed1c53048b2"
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
