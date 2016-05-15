require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kcrash-5.22.0.tar.xz"
  sha256 "0f9f5e024f98b9cb71c8262108e58814eb62c72a556a0da1fbd7cb329f4d11e4"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcrash.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kcoreaddons"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
