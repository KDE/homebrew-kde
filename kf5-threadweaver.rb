require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.22/threadweaver-5.22.0.tar.xz"
  sha1 "9a7100670fe21a0d27449ff559d2d27b7adb8b18"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/threadweaver.git'

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
