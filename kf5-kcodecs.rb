require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kcodecs-5.36.0.tar.xz"
  sha256 "6cff3e88f9cd623509caad8cc4e20993189fdc5071f9b5c05fbcf58850dabe6c"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcodecs.git"

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
