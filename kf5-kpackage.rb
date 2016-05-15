require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.16/kpackage-5.16.0.tar.xz"
  sha1 "946575a1fb83bef5580e8accf37c0d7967159b9f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kpackage.git'

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
