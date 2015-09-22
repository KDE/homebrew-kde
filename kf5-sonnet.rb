require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.14/sonnet-5.14.0.tar.xz"
  sha1 "44b82628f4765bdc20773576012b23f548a72567"
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
