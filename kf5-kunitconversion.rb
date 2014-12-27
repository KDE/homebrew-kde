require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kunitconversion-5.5.0.tar.xz"
  sha1 "3d8fafcd2c08a3b461c42512e81759d113241ff2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kunitconversion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
