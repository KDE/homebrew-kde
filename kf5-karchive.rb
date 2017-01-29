require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/stable/frameworks/5.30/karchive-5.30.0.tar.xz"
  sha256 "18b35d437e7cbf6f00983d0f66372cbd6a0daedaa58e6c092838c20845571f38"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/karchive.git'

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
