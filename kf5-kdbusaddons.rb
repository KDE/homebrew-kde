require "formula"

class Kf5Kdbusaddons < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/unstable/frameworks/4.97.0/kdbusaddons-4.97.0.tar.xz"
  sha1 "71f748b7b28f981b0d65419eb868b7c26f489fa1"

  head 'git://anongit.kde.org/kdbusaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "shared-mime-info"
  depends_on "d-bus"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
