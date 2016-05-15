require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.16/kwallet-5.16.0.tar.xz"
  sha1 "3d337d88b54296f73a92466425cefd381bc9f6de"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwallet.git'

  depends_on "libgcrypt"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-knotifications"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
