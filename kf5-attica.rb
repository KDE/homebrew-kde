require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.30/attica-5.30.0.tar.xz"
  sha256 "5b44207c93f42b84e99fc7e110025059e3023a1dac2e4f5bd019335c7a331eed"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
