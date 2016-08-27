require "formula"

class Kf5Kemoticons < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kemoticons-5.25.0.tar.xz"
  sha256 "072bdcfb2437f25e2d4bcc02bef7d80de200953bdd7f822c2649c005a40abb9d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kemoticons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kservice"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
