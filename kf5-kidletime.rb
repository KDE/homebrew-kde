require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kidletime-5.30.0.tar.xz"
  sha256 "0667866bf1a3cdeb976497ef3afe2ee806a48a85a21144448be5c3583cdf72ed"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kidletime.git'

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
