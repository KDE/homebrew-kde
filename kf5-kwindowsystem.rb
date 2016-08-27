require "formula"

class Kf5Kwindowsystem < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kwindowsystem-5.25.0.tar.xz"
  sha256 "b8228dddcc6487e234f81239bea7ca7ae261af8fef7b9e5d7a8b49aa3ac5d0dd"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwindowsystem.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
