require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.39/kapidox-5.39.0.tar.xz"
  sha256 "d6701d35aa45b65dbf442d3325416c3100aa317a94fbeeb8f25595c782d2d58a"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kapidox.git"

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
