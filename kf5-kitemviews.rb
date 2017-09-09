require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kitemviews-5.38.0.tar.xz"
  sha256 "46df0b2a0fe436cac2e1984d9038ac894ac86d9650db5328fa7069a13f46b151"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kitemviews.git"

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
