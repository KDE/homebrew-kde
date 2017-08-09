require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kapidox-5.36.0.tar.xz"
  sha256 "79a505ed2ef7a755115b1da7e37c45fe6a2eda799ea9f4da15766fa5977f3fa0"
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
