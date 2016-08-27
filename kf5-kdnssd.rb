require "formula"

class Kf5Kdnssd < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kdnssd-5.25.0.tar.xz"
  sha256 "256a5c9c1598b0b4f55730efc198e5c6d27aea38bd245725b204e29dc0a517de"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

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
