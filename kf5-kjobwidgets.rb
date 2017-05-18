require "formula"

class Kf5Kjobwidgets < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kjobwidgets-5.34.0.tar.xz"
  sha256 "eefedadad329c1858604af076bc56748f2c7417c52d080c5aa8724b783393d53"

  head "git://anongit.kde.org/kjobwidgets.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
