require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kded-5.34.0.tar.xz"
  sha256 "f8fb127da4cbe1c72f7ddf118e54298d5aa8199e2130e38df30f98c7d6e1c463"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kded.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "qt5"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
