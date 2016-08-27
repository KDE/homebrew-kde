require "formula"

class Kf5Kservice < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kservice-5.25.0.tar.xz"
  sha256 "a75a5c8780dbb4e5ef7e5f1d3cc91808f44a640f1ac6b788418df261379ee32c"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kservice.git'

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
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
