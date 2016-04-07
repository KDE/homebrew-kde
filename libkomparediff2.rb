require "formula"

class Libkomparediff2 < Formula
  url "http://download.kde.org/stable/applications/15.12.3/src/libkomparediff2-15.12.3.tar.xz"
  sha256 "7602643436f4a3fec003c2468d77b3b8590cf3d32c535d85805a469b490686c7"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/libkomparediff2.git'

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
