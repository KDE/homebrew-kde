require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kparts-5.5.0.tar.xz"
  sha1 "bd6f4e1005aa498a3de976adf6fa73bc9381010e"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kparts.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kio"

  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
