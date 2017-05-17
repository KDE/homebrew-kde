require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kapidox-5.34.0.tar.xz"
  sha256 "6ff31ce240c61c61b3fa807617f418ece574458dd46ea3acdb598613cd2f0da4"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kapidox.git'

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
