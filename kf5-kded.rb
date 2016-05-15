require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kded-5.22.0.tar.xz"
  sha256 "d8b8dc42c32713061db46570782a4ca8e8fa9410191a6857e1d7c77a4d7ecffd"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kded.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "qt5" => "with-dbus"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
