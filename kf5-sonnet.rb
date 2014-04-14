require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/sonnet-4.98.0.tar.xz"
  sha1 "373f6ec2edbf66fc987fdfda44f011d2d4069404"

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
