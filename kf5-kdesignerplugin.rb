require "formula"

class Kf5Kdesignerplugin < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kdesignerplugin-5.34.0.tar.xz"
  sha256 "50a9b3c2a58de0a94804d550e06e3d227dddbfa297133c0e76b2c1cccfcbcaca"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesignerplugin.git'

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
#  depends_on "haraldf/kf5/kf5-kdewebkit"
  depends_on "haraldf/kf5/kf5-kplotting"
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
