require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/stable/frameworks/5.39/karchive-5.39.0.tar.xz"
  sha256 "3cc31b2449bf690a3703d339875510f211dfb3d774737d80237da3474dde6865"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/karchive.git"

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
