require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.16/kdesu-5.16.0.tar.xz"
  sha1 "09e0c86d921977ad8c2dc2cdf7f3ec81f6a830b7"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt5" => "with-dbus"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
