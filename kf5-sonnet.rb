require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.5/sonnet-5.5.0.tar.xz"
  sha1 "dc36d735ff62ae72bd6a7c3247675dbcce2fff10"
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
