require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/stable/frameworks/5.25/karchive-5.25.0.tar.xz"
  sha256 "0c338f1e1adc5522de6555fa3fa8c6ebcde29ce48e1f5959beca12d46aea88d8"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/karchive.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
