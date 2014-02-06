require "formula"

class Konsole < Formula
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/konsole.git', :branch => 'frameworks'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kconfig"
  depends_on "qt5"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_CXX_FLAGS='-D_DARWIN_C_SOURCE'"

    system "cmake", ".", *args
    system "make", "install"
  end
end
