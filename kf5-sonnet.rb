require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.2.0/sonnet-5.2.0.tar.xz"
  sha1 "041493366236079b52fdf41e6dbed3aacb59893e"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

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
