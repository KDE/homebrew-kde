require "formula"

class Kf5Kconfigwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kconfigwidgets-5.34.0.tar.xz"
  sha256 "13265a75a3617cb51da521957f1fa34d40f5960fea73f41e16373ba7ef559340"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kconfigwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt5"
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
