require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kwidgetsaddons-5.36.0.tar.xz"
  sha256 "bc9a62d24f6bdd0e8830481f915744cf640660c99ecb54cbeea73de5b218a20b"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwidgetsaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
