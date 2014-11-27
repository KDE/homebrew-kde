require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.4/kplotting-5.4.0.tar.xz"
  sha1 "b3954b025f8270dca27baad2ced629377ba31676"
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
