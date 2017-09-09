require "formula"

class Kf5Kwindowsystem < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kwindowsystem-5.38.0.tar.xz"
  sha256 "2c16eb635714ff122b9348c0cc880be60d08c817c98026029f78434d918db90b"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwindowsystem.git"

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
