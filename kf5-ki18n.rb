require "formula"

class Kf5Ki18n < Formula
  homepage "http://www.kde.org/"
#  url "http://download.kde.org/unstable/frameworks/4.95.0/ki18n-4.95.0.tar.xz"
#  sha1 "5b6423af0bf96c07cc298ec560616fee4c625f8e"

  head 'git://anongit.kde.org/ki18n.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "gettext" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kjs"

  def install
    args = std_cmake_args
    args << "-DCMAKE_PREFIX_PATH=\"#{Formula.factory('qt5').opt_prefix};#{Formula.factory('kf5-extra-cmake-modules').opt_prefix}\""
    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    system "cmake", ".", *args
    system "make", "install"
  end
end
