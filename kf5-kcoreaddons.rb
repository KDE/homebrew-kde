require "formula"

class Kf5Kcoreaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kcoreaddons-5.36.0.tar.xz"
  sha256 "9d4b26bf22d1326c37f33aa4727942325cad2b23e5b3f1e32ec9ee558e9b5594"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcoreaddons.git"

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
