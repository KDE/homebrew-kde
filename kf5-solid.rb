require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.39/solid-5.39.0.tar.xz"
  sha256 "d98c1bc67a8483d42d76d0369bab3255b30420a5bd41bc4730cabbf03e3c74a5"
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
