require "formula"

class Kf5Kjobwidgets < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/kjobwidgets-4.95.0.tar.xz"
#  sha1 "2d2c66e7f84dc5a180945150c90ae6e08cb78e98"

  head 'git://anongit.kde.org/kjobwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
