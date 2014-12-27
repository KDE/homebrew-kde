require "formula"

class Kf5Knewstuff < Formula
  url "http://download.kde.org/stable/frameworks/5.5/knewstuff-5.5.0.tar.xz"
  sha1 "f6d7c2d53414aaa589cdcc545ddfc7efc3b32fd4"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/knewstuff.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
