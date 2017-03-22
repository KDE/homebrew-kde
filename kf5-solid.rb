require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.32/solid-5.32.0.tar.xz"
  sha256 "659310686464d12efd7223f652a82b3401094a57f36ba034e8f16d9577ac1eca"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
