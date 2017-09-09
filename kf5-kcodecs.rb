require "formula"

class Kf5Kcodecs < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kcodecs-5.38.0.tar.xz"
  sha256 "31a22d37da33d86d492b4bf5e439566d8f6a0783f74382931cee4c59a482dd32"
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
