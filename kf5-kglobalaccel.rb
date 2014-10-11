require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kglobalaccel-5.3.0.tar.xz"
  sha1 "2644b8a7cc5e2ac8099ca8acdc39f1a4f2a47df6"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kglobalaccel.git'

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
