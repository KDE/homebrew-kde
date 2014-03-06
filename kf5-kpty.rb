require "formula"

class Kf5Kpty < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kpty-4.97.0.tar.xz"
  sha1 "e332ae663ca1fa2ce66b7b7aa1a46416fa1b1d95"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kpty.git'

  depends_on "cmake" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons" => :build
  depends_on "haraldf/kf5/kf5-kjs" => :build
  depends_on "haraldf/kf5/kf5-ki18n" => :build

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
  end
end
