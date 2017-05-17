require "formula"

class Kf5Kguiaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kguiaddons-5.34.0.tar.xz"
  sha256 "1dbf389b86fb9978999d0d0486844e3a0bba91991baaba4c05b03629fce6b4da"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kguiaddons.git'

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
