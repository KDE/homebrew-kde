require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.25/solid-5.25.0.tar.xz"
  sha256 "bd60b642389d5acb0fafb204663ee92a6c44992cb3bb5df7fd34432c32ad04f2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
