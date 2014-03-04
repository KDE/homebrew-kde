require "formula"

class Kf5Sonnet < Formula

  url "http://download.kde.org/unstable/frameworks/4.97.0/sonnet-4.97.0.tar.xz"
  sha1 "d9ada0ad0db9ced7cbaeb725360a2485d08ad203"

  head 'git://anongit.kde.org/sonnet.git'

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
