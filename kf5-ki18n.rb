require "formula"

class Kf5Ki18n < Formula
  url "http://download.kde.org/stable/frameworks/5.32/ki18n-5.32.0.tar.xz"
  sha256 "4ee7c032f2ff6f86af6d6171d4eef3ee0c66816c523e5e90bc14120f05df1d19"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/ki18n.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "gettext" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
