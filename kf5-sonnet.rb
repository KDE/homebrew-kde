require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.34/sonnet-5.34.0.tar.xz"
  sha256 "7aa7342dddc351ee7c46a874498cb89fd96679a5b095d9f16cbe9c9511ccfd19"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/sonnet.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
