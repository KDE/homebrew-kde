require "formula"

class Kf5Kimageformats < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kimageformats-5.34.0.tar.xz"
  sha256 "5c466ba11a7fcb393c79b5918c07832a07d302ae374c3b08c74d4c4c19793661"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kimageformats.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "openexr"
  depends_on "jasper"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
