require "formula"

class Kf5Ktextwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.25/ktextwidgets-5.25.0.tar.xz"
  sha256 "4b2d9b999ba9fbd7f79105d15f0c8bcc3f3f4982d0b71b1c06e4ade6d63eb614"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/ktextwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
