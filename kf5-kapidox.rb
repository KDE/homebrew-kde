require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.4/kapidox-5.4.0.tar.xz"
  sha1 "140a3b9cccb8a09e1e9c62ec24ac7102bb3f437f"
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
