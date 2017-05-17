require "formula"

class Kf5Kcmutils < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kcmutils-5.34.0.tar.xz"
  sha256 "1e12b79c13651e6086f315249d1be8cbe84fb996411eb50db0194b7c2ca7a2ac"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcmutils.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kdeclarative"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
