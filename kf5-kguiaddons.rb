require "formula"

class Kf5Kguiaddons < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kguiaddons-4.97.0.tar.xz"
  sha1 "005adb0eed27d752923e426520501a44ab262812"
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
