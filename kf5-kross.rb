require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.36/portingAids/kross-5.36.0.tar.xz"
  sha256 "586a0d68ab924dd48d7f41f04ac412b6356e33dd9fb962043480347ee7ff127a"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kross.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
