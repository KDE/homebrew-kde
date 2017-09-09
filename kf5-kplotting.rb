require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kplotting-5.38.0.tar.xz"
  sha256 "e2d8ef624735a56f3998c88af6f06209221af5f27ef05096d65ebb124dc56ec3"
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
