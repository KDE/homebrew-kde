require "formula"

class Kf5Kservice < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kservice-4.97.0.tar.xz"
  sha1 "8fff6641e84faa183c0d0e3624c5c074e77c3c38"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kservice.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-kdoctools"
  depends_on "haraldf/kf5/kf5-kdbusaddons"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
  end
end
