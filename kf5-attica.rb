require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.39/attica-5.39.0.tar.xz"
  sha256 "4ec1527e54e029c88135b5ed4851874ebb19a566b3c690c62ce6118b42112795"
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
