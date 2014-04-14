require "formula"

class Kf5Kitemmodels < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kitemmodels-4.98.0.tar.xz"
  sha1 "82643bea67c770f8e251d5551d07564bec7ba0f1"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemmodels.git'

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
