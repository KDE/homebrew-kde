require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/solid-5.3.0.tar.xz"
  sha1 "fd2316cb9f0a32eea174c82743915d8d2c8e0ba6"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

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
