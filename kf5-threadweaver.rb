require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.38/threadweaver-5.38.0.tar.xz"
  sha256 "db6dca72315a376fa8852f0059113a5880a002e311e5f4591138303b69a209b5"
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
