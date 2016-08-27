require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.25/sonnet-5.25.0.tar.xz"
  sha256 "c3be349e3802dfa73e0ad719f60adf454a42fee30a2c7cb7dc76073d71124f90"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
