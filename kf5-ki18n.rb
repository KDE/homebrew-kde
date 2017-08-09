require "formula"

class Kf5Ki18n < Formula
  url "http://download.kde.org/stable/frameworks/5.37/ki18n-5.37.0.tar.xz"
  sha256 "4d94f4f676161507149886c6f9c4a16a17556bcb4b9c24b4549a53b82ef13ab0"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/ki18n.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "gettext" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
