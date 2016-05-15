require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.16/kapidox-5.16.0.tar.xz"
  sha1 "0939d5c404b9bd50cbfe97d05fba7cf93b3877d3"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kapidox.git'

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
