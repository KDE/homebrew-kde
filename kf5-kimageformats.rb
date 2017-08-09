require "formula"

class Kf5Kimageformats < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kimageformats-5.36.0.tar.xz"
  sha256 "09dd24c46bfa1d5a7422849de2940fd6aa66bf63c4b915cf7f6d7c51533320c8"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kimageformats.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "openexr"
  depends_on "jasper"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
