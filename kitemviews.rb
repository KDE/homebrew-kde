require "formula"

class Kitemviews < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.95.0/kitemviews-4.95.0.tar.xz"
  sha1 ""

  head 'git://anongit.kde.org/kitemviews.git'

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
