require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kcodecs-4.97.0.tar.xz"
  sha1 "ba3534dc98d4ceb3f37e7ae9be9ef23fc1b6cf04"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcodecs.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end
