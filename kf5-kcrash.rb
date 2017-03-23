require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.32/kcrash-5.32.0.tar.xz"
  sha256 "e343eaaa6ee39c7e1fb1f309bbeae6fadebec7592dd9b58b6fd523246f9633ff"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcrash.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kcoreaddons"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
