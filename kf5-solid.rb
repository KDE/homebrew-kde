require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.6/solid-5.6.0.tar.xz"
  sha1 "83e32f5f604fa6e6f099ffb1b5e51b61a510364a"
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
