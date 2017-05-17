require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kglobalaccel-5.34.0.tar.xz"
  sha256 "caf05b77cd387ce21c7571fdf16e6d5e7b4337de1d73c0e9764b760c0e6e62c4"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kglobalaccel.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
