require "formula"

class Kf5Kplotting < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kplotting-5.34.0.tar.xz"
  sha256 "501f13c16718907c9b852d24a55605fe6e51e6b7cf514e04a81e8980c04adeb9"

  head "git://anongit.kde.org/kplotting.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
