require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.6/kapidox-5.6.0.tar.xz"
  sha1 "bdc216e36f00cd6508fb4671b25a821de1b0ce41"
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
