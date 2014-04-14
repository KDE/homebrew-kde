require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kitemviews-4.98.0.tar.xz"
  sha1 "7c7f44ea1f7b8d296eb4bdbec8abe96a8734fe25"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemviews.git'

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
