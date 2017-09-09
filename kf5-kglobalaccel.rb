require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kglobalaccel-5.38.0.tar.xz"
  sha256 "ba0a9084bd456fe4b9b9e308a0105ea744cf980bf4b5fcb0b1cd0a302a7cb5e7"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kglobalaccel.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
