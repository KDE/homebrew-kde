require "formula"

class Kf5SyntaxHighlighting < Formula
  url "http://download.kde.org/stable/frameworks/5.38/syntax-highlighting-5.38.0.tar.xz"
  sha256 "d4b887e2b4c0bb0d0c723325b11897d1ab38a644e3276d57eae8393928783680"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/syntax-highlighting.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
