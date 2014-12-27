require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/stable/frameworks/5.5/karchive-5.5.0.tar.xz"
  sha1 "c3aa5927d5856c6536798d17bedb2f6f8c2b422d"
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
