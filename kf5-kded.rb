require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kded-5.30.0.tar.xz"
  sha256 "2d67d51c7ae8c60a329a8aaa55bddb4ce09b52d5aa4ba6583175441063b715eb"
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
