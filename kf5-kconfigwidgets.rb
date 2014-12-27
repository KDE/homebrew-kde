require "formula"

class Kf5Kconfigwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kconfigwidgets-5.5.0.tar.xz"
  sha1 "fa0d63b77f9a1d8a04e99e398a51bd4263cf1510"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kconfigwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "qt5" => "with-d-bus"
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
