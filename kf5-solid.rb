require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.0.0/solid-5.0.0.tar.xz"
  sha1 "0b87fd5a1a479881ac6094cc1fa116eabc36e40a"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

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
