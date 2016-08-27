require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kcodecs-5.25.0.tar.xz"
  sha256 "d5bef19f3575784e93b55db76bbaea7f8dba2bed4ffd9b9fbbb52db6d85f4ea5"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcodecs.git'

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
