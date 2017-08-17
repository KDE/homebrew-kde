require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.37/portingAids/kross-5.37.0.tar.xz"
  sha256 "611279d67a599d86e864980e50585eece994cb9d70569d533fed0ab48d33f31a"
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
