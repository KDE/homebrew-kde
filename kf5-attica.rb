require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.8/attica-5.8.0.tar.xz"
  sha1 "aea15d99d1d48969b8e53091295d18802231c6cc"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

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
