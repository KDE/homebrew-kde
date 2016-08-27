require "formula"

class Kf5Kcmutils < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kcmutils-5.25.0.tar.xz"
  sha256 "f58a89543d52c82b0a9ae527b2a73141ef9f970d7cf6393a47f0b42f61696931"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcmutils.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kdeclarative"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
