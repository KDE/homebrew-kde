require "formula"

class Kf5Ktextwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.36/ktextwidgets-5.36.0.tar.xz"
  sha256 "8afb6e8178ecc45cbeb054b26ad1e4b928eccd61d6b0d883d7abd650fd031c2d"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/ktextwidgets.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
