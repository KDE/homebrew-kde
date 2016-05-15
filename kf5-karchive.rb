require "formula"

class Kf5Karchive < Formula
  url "http://download.kde.org/stable/frameworks/5.16/karchive-5.16.0.tar.xz"
  sha1 "1198a2db75f0b776586fb798da4fd04a71b80229"
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
