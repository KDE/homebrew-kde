require "formula"

class Libkomparediff2 < Formula
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.04.1/src/libkomparediff2-17.04.1.tar.xz"
  sha256 "7733c98159d18de3d33c0d4dc0cf03255b4a6c303d39439b5290db2afb9e80e5"

  head "git://anongit.kde.org/libkomparediff2.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kcodecs"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kio"
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
