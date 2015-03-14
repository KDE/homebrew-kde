require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.8/kapidox-5.8.0.tar.xz"
  sha1 "743d832c06eb2774f023e2d8db070b3e491929a1"
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
