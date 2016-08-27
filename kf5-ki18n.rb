require "formula"

class Kf5Ki18n < Formula
  url "http://download.kde.org/stable/frameworks/5.25/ki18n-5.25.0.tar.xz"
  sha256 "5d9ae669b2c6a7637489ffb04d603762512fe8c78501ea5318acc387741e7167"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/ki18n.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "gettext" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
