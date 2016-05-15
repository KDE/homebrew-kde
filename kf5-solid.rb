require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.22/solid-5.22.0.tar.xz"
  sha1 "0536ed9704246f8c0980724e9702b82dd2d8908f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

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
