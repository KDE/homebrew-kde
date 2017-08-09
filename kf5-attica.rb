require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.36/attica-5.36.0.tar.xz"
  sha256 "8dd2998f5c9b5f727ec406385f065907f1c6b094ac47d3c1eaae2b858c9f258a"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

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
