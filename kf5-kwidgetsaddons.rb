require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kwidgetsaddons-5.10.0.tar.xz"
  sha1 "3f5a3f7061ab4f5dd52e4822e8af72b946a94189"
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
