require "formula"

class Kf5Kguiaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kguiaddons-5.3.0.tar.xz"
  sha1 "2d18b759201b25176b41281ae36516ee62365d97"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kguiaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
