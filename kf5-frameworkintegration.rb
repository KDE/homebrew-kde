require "formula"

class Kf5Frameworkintegration < Formula
  url "http://download.kde.org/stable/frameworks/5.5/frameworkintegration-5.5.0.tar.xz"
  sha1 "ab894fe1ff77a2603f5b632a2dfb1a9126ba76a3"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/frameworkintegration.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end
