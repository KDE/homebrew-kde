require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/solid-4.98.0.tar.xz"
  sha1 "a293a78ed29e322c313f18ab94cf440fdb288446"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
