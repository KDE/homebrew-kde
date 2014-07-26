require "formula"

class Kf5Kitemviews < Formula
  url "http://download.kde.org/stable/frameworks/5.0.0/kitemviews-5.0.0.tar.xz"
  sha1 "1c12265c56908a12fee52c471db90a9a3177dfff"
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
