require "formula"

class Libkomparediff2 < Formula
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.08.0/src/libkomparediff2-17.08.0.tar.xz"
  sha256 "394c0119631b865ab25f5b7165b0b13451f5890ea1ef553ac3f5eda78a322d5b"

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
