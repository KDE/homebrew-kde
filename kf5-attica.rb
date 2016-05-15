require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.22/attica-5.22.0.tar.xz"
  sha1 "23c4944898016ea1d4760a2c559356dd306a7c33"
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
