require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kidletime-5.22.0.tar.xz"
  sha1 "1030b1d9b99c316b8e616b4f0d5ed39982751c9b"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kidletime.git'

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
