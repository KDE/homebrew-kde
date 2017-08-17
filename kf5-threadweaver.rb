require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.37/threadweaver-5.37.0.tar.xz"
  sha256 "a4f79b937020f4a7b44e8fc1a6339828cccea6d306a11084f46bfd90833863c1"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/threadweaver.git"

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
