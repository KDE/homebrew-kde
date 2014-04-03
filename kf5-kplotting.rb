require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kplotting-4.97.0.tar.xz"
  sha1 "3f715abce02ce1d651d0e4a7d80a602232146eb9"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kplotting.git'

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
