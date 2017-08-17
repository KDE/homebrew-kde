require "formula"

class Kf5Kservice < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kservice-5.37.0.tar.xz"
  sha256 "196e9bdbdb28bfda75120cf1f7d49f68bc345f248cdca8f718bee6d1be2fbaff"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kservice.git"

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
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
