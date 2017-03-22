require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.32/kplotting-5.32.0.tar.xz"
  sha256 "dbacaaff7ab2964f747c5e54774a9d05b92b22497d4bb1a81185a04e5b751728"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kplotting.git'

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
