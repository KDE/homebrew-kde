require "formula"

class Kf5Sonnet < Formula
  url "http://download.kde.org/stable/frameworks/5.30/sonnet-5.30.0.tar.xz"
  sha256 "99fd42d919d3350e22ae99fc480a14bc30ebd461b064ef24aed5042c772a91c4"
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
