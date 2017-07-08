require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kdesu-5.36.0.tar.xz"
  sha256 "8af37b0ca1563c58e5f8446f66286b2d418946960575cf6f444ae314aa198f06"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdesu.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt5"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
