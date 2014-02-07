require "formula"

class Kf5Kconfig < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kconfig-4.95.0.tar.xz"
#  sha1 "0d896407a8f5d8a14df2456a8681c39b583bf9e5"

  head 'git://anongit.kde.org/kconfig.git'

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
