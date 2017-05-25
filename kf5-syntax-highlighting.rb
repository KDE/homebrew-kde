require "formula"

class Kf5SyntaxHighlighting < Formula
  url "http://download.kde.org/stable/frameworks/5.34/syntax-highlighting-5.34.0.tar.xz"
  sha256 "884b266cfcec466d7f86053c7bcefccf27b256651ad123656939c9bfe9e2ce67"
  homepage "http://www.kde.org/"

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
