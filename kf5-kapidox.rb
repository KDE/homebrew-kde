require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.9/kapidox-5.9.0.tar.xz"
  sha1 "66c1bc8a19afcc43aa4cbb8d48002fa466864e73"
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
