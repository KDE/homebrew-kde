require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.30/solid-5.30.0.tar.xz"
  sha256 "b0da3820036ead46d97826971567e70b1e9ba08f8b3801fefba8219dc6d52e83"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
