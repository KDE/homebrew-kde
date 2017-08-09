require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kplotting-5.36.0.tar.xz"
  sha256 "a7e7b00f0202ac97b0ec36e7acd240a8f9c8cacdec45a71a1314e37a7a9a4b3d"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kplotting.git"

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
