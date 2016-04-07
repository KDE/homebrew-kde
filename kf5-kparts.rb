require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.16/kparts-5.16.0.tar.xz"
  sha1 "1cc7901e49222936940de1b3dd00ef1a2ca2bdbd"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kparts.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kio"

  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
