require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kwidgetsaddons-4.97.0.tar.xz"
  sha1 "23eeba7df209747c1a8c19ed5c0d7257ac4853c1"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwidgetsaddons.git'

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
