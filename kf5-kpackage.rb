require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kpackage-5.25.0.tar.xz"
  sha256 "47c641dc173d5b597937b00fe2e01a0058916273278a7d44f4c3ae932b753013"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kpackage.git'

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
