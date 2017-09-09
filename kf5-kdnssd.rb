require "formula"

class Kf5Kdnssd < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kdnssd-5.38.0.tar.xz"
  sha256 "1d70cc194e45fe12e09005948fb794a3deb1e2d58d0269bef3a30a9cfbf32f80"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

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
