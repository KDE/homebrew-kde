require "formula"

class Kf5Kinit < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kinit-4.97.0.tar.xz"
  sha1 "78afa529b2edf0355350e8792ac940cc0f8aba29"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kinit.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end
