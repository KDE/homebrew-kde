require "formula"

class Kf5Kguiaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kguiaddons-5.25.0.tar.xz"
  sha256 "136cb22285eeb7e15a02cdcc8e8bc65edc777dd923125bd64695eb10c9ff5d9f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kguiaddons.git'

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
