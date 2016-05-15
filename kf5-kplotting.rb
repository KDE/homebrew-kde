require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kplotting-5.22.0.tar.xz"
  sha256 "13c3e28d7e57f3e55da7e450b9c92fe4e9c3e4e87de249cf481b882154f75152"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kplotting.git'

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
