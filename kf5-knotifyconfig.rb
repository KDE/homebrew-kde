require "formula"

class Kf5Knotifyconfig < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/knotifyconfig-5.34.0.tar.xz"
  sha256 "d3d3c9e3fa77bcabd6848d9969e3e20d478fb4065a0c59c8f5129c83b7109453"

  head "git://anongit.kde.org/knotifyconfig.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
