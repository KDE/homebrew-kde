require "formula"

class Kf5Knotifyconfig < Formula
  url "http://download.kde.org/stable/frameworks/5.25/knotifyconfig-5.25.0.tar.xz"
  sha256 "f3e0a3d1217370f8bec645c84730057f17df400fe284c45c2feb89e6820afbca"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/knotifyconfig.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
