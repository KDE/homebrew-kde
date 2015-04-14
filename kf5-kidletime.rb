require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.9/kidletime-5.9.0.tar.xz"
  sha1 "41393450f4d59b445aa1ab37e27b6e74e725fc9d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kidletime.git'

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
