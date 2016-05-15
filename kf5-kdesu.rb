require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kdesu-5.22.0.tar.xz"
  sha256 "6d2542cead6a59854082b004f745f69e6c04a31c7090e3f5d6fbfb26464d59cb"
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
