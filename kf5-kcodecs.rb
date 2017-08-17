require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kcodecs-5.37.0.tar.xz"
  sha256 "6a2fe7e8e5d82490373f973c50dcac484d75081daff22efb58deae5dd649b34e"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcodecs.git"

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
