require "formula"

class Kf5Kdiagram < Formula
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdiagram.git"

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
