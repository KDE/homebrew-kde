require "formula"

class Kf5Kconfigwidgets < Formula
  desc "Widgets for KConfig"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kconfigwidgets-5.39.0.tar.xz"
  sha256 "fc77a295823327aa602d246f2e7da8094f5a97d56c1d69916e3ad9aa71b4ccc4"

  head "git://anongit.kde.org/kconfigwidgets.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kauth"
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kguiaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
