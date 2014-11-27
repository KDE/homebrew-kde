require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.4/sonnet-5.4.0.tar.xz"
  sha1 "9c3d3c7d5d27010344c09529a9126908f6d70f61"
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
