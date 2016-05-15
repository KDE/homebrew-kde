require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.16/sonnet-5.16.0.tar.xz"
  sha1 "0e015f7b1eefded02ba853a2d93ac1fdc9a5fd7b"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
