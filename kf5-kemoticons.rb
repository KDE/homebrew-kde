require "formula"

class Kf5Kemoticons < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kemoticons-5.37.0.tar.xz"
  sha256 "d8c6bd991b04b85a6a7ab891132e6e3f46427467b67a45a00c7bd416343aa9b3"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kemoticons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kservice"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
