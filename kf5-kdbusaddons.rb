require "formula"

class Kf5Kdbusaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kdbusaddons-5.37.0.tar.xz"
  sha256 "9140b649e140eb134d7290e3f268658900a61c3d50002ca1e7d772726756851c"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdbusaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "shared-mime-info"
  depends_on "d-bus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
