require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.7/kapidox-5.7.0.tar.xz"
  sha1 "165fb954ad7dcb4a44db9a9847a4643ebf497d67"
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
