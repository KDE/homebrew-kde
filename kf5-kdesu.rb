require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kdesu-5.22.0.tar.xz"
  sha1 "8b0126c8f5f7f5af3737be97f51692ab08f52c5f"
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
