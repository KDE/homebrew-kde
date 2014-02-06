require "formula"

class Ktexteditor < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/ktexteditor-4.95.0.tar.xz"
#  sha1 ""

  head 'git://anongit.kde.org/ktexteditor.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/karchive"
  depends_on "haraldf/kf5/kjs"
  depends_on "haraldf/kf5/ki18n"
  depends_on "haraldf/kf5/kconfig"
  depends_on "haraldf/kf5/kguiaddons"
  depends_on "haraldf/kf5/kjobwidgets"
  depends_on "haraldf/kf5/kio"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('extra-cmake-modules').opt_prefix}\""

    system "cmake", ".", *args
    system "make", "install"
  end
end
