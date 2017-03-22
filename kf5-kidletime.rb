require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.32/kidletime-5.32.0.tar.xz"
  sha256 "9071fce23dfad8e63ee0bc5187e0bc8e6d33a1722d13cf36a95c5e6dd7e87d66"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kidletime.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
