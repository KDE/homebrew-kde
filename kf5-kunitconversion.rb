require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kunitconversion-5.25.0.tar.xz"
  sha256 "c3c2248b82aae17ff14b5c64ffbee40f5418450a26baa9f8fab3110ae88d7895"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kunitconversion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
