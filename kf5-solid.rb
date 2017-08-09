require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.36/solid-5.36.0.tar.xz"
  sha256 "b10d3d5e1b1f30dd9e283575ab66a4279f0114207b6a69ab1a657403ef03efac"
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
