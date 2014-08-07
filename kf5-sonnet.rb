require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.1.0/sonnet-5.1.0.tar.xz"
  sha1 "083277c6360d73ffc6a9de9872f527c65b2073dc"
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
