require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kitemviews-4.97.0.tar.xz"
  sha1 "988ba3f9878e4d5bff313f77078822d8bc463a6d"
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
