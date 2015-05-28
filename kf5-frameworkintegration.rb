require "formula"

class Kf5Frameworkintegration < Formula
  url "http://download.kde.org/stable/frameworks/5.10/frameworkintegration-5.10.0.tar.xz"
  sha1 "c2d1e0dca9c2edb8f7d8b9c7b5d8a9afc19c46f6"
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
