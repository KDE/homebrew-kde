require "formula"

class Kf5Kdeclarative < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kdeclarative-5.3.0.tar.xz"
  sha1 "251ee69cc5624c06e8b7dedbf7d9095b560b61cb"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdeclarative.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
