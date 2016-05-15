require "formula"

class Kf5Kpty < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kpty-5.22.0.tar.xz"
  sha256 "ab85e9d9f6001c9752d7b32276f19c4cc85a0e980f12d64bd7d38056c8e68e8a"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kpty.git'

  depends_on "cmake" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons" => :build
  depends_on "haraldf/kf5/kf5-kjs" => :build
  depends_on "haraldf/kf5/kf5-ki18n" => :build

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
