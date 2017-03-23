require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.32/threadweaver-5.32.0.tar.xz"
  sha256 "103c20fa6a024a030a04ee34960e14504663fe41d3cd155db98a348f7f16fee2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/threadweaver.git'

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
