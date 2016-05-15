require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.22/attica-5.22.0.tar.xz"
  sha256 "a77a4e95fe2ce16ead6bebafb8fbd90c1ce3d3f7d4fe44388bc2acec3bb746c4"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

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
