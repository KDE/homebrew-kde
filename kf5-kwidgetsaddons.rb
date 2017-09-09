require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kwidgetsaddons-5.38.0.tar.xz"
  sha256 "45ee4f81cd91e61e82306f757a06849644fde73e09650e0498797cdc3a4604fa"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwidgetsaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
