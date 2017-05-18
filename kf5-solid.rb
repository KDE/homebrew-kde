require "formula"

class Kf5Solid < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/solid-5.34.0.tar.xz"
  sha256 "2b12b8969211aeeed6becde9ed4fea264a68bdc98e0cf7cecb41873b6e107f0a"

  head "git://anongit.kde.org/solid.git"

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
