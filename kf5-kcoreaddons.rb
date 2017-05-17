require "formula"

class Kf5Kcoreaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kcoreaddons-5.34.0.tar.xz"
  sha256 "20455e6bd7b36af50d67e2a11fa0cb9f4e301b61da55e46e67e4c28cf62279f9"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcoreaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "shared-mime-info"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
