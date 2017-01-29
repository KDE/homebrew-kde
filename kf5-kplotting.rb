require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kplotting-5.30.0.tar.xz"
  sha256 "f009db3cae5329c8e123cd72a3ff185ddfff0606d38d70c008902e524df89903"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kplotting.git'

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
