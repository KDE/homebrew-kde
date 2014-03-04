require "formula"

class Kf5Kitemviews < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.97.0/kitemviews-4.97.0.tar.xz"
  sha1 "988ba3f9878e4d5bff313f77078822d8bc463a6d"

  head 'git://anongit.kde.org/kitemviews.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
