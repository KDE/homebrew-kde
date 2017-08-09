require "formula"

class Kf5Kpty < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kpty-5.36.0.tar.xz"
  sha256 "64c25954915c2070edfd2e0649110ce4bafa19af352f9ac3e4979f68e06daafc"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpty.git"

  depends_on "cmake" => :build
  depends_on "qt"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons" => :build
  depends_on "haraldf/kf5/kf5-kjs" => :build
  depends_on "haraldf/kf5/kf5-ki18n" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
