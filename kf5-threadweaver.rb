require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/threadweaver-5.3.0.tar.xz"
  sha1 "42350ae453273f55ee08efa39256868613d81f85"
  homepage "http://www.kde.org/"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
