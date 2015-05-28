require "formula"

class Kf5Kimageformats < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kimageformats-5.10.0.tar.xz"
  sha1 "3228f3a9b98c62a1b5992bc9910a0d8068d900bc"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kimageformats.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "openexr"
  depends_on "jasper"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
