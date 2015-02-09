require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/stable/frameworks/5.6/karchive-5.6.0.tar.xz"
  sha1 "452d36afff001e15bc12cb789d2c2482190adc94"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/karchive.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
