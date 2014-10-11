require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kitemviews-5.3.0.tar.xz"
  sha1 "2768093ff3df5f4f90c852c8d9dbf68096faddbd"
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
