require "formula"

class Kf5Kconfig < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kconfig-4.97.0.tar.xz"
  sha1 "e007110a73130dd50ede3d1e24ef1dcb0581079f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kconfig.git'

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
