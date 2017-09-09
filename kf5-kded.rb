require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kded-5.38.0.tar.xz"
  sha256 "8b96b50313783b5edcf5bb8a0bc4873a844cb1ca662feb0ace9a932e8bfc5277"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kded.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
