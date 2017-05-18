require "formula"

class Kf5Kservice < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kservice-5.34.0.tar.xz"
  sha256 "6730f99cd9e187256703ee32942adf6d4370452d05a350a40d380a9d88e5336a"

  head "git://anongit.kde.org/kservice.git"

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-kcrash"
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args

    system "cmake", ".", "-DBUILD_TESTING=OFF", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
