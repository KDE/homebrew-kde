require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.38/solid-5.38.0.tar.xz"
  sha256 "1052830aaed16391563dc35fe0e01bba2813acf2e0c70fa2223d54d2732b6cac"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/solid.git"

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
