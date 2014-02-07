require "formula"

class Kf5Kwidgetsaddons < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kwidgetsaddons-4.95.0.tar.xz"
#  sha1 "6c8448d82216941a4fc458d99f350fa1056a1c71"

  head 'git://anongit.kde.org/kwidgetsaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
