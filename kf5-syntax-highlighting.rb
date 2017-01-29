require "formula"

class Kf5SyntaxHighlighting < Formula
  url "http://download.kde.org/stable/frameworks/5.30/syntax-highlighting-5.30.0.tar.xz"
  sha256 "a3d4d68c45f95133b4f242be24ecf88620478bbcd84ced1f1bea080667783746"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/syntax-highlighting.git'

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
