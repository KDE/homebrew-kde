require "formula"

class Kf5SyntaxHighlighting < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.32/syntax-highlighting-5.32.0.tar.xz"
  sha256 "a31f5f66b642ffdb2839c6278428961839b2d13a2ca80561e5eff13a4a3f35b5"

  head "git://anongit.kde.org/syntax-highlighting.git"

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
