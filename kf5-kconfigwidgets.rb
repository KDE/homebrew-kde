require "formula"

class Kf5Kconfigwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kconfigwidgets-5.38.0.tar.xz"
  sha256 "1d70a761eefe60e6f7beb3517ed64edbb6266cfe85bbb65603c9764e524b6170"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kconfigwidgets.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-kauth"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
