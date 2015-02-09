require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.6/sonnet-5.6.0.tar.xz"
  sha1 "8a1f20df95ebbb3df093f75bd3925e703167d438"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

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
