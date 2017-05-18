require "formula"

class Kf5Frameworkintegration < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/frameworkintegration-5.34.0.tar.xz"
  sha256 "40ac4623c0292442853ac8e905c0282aaa0063c594693beae7c07f69bfc80143"

  head "git://anongit.kde.org/frameworkintegration.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
  end
end
