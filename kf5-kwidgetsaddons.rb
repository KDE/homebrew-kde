require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kwidgetsaddons-4.98.0.tar.xz"
  sha1 "873a9e42eef9e55ba610d26d18f45181a23708be"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwidgetsaddons.git'

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
