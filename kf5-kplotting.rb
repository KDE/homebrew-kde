require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kplotting-5.22.0.tar.xz"
  sha1 "5e63abf52a5555a664124558b226250bf49d9b00"
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
