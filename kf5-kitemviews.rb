require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kitemviews-5.36.0.tar.xz"
  sha256 "74ead758a65746d9404bfa4cfbebb95fdada196246b38b07b68c7094cdf22a06"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kitemviews.git"

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
