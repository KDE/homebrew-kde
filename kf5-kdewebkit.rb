require "formula"

class Kf5Kdewebkit < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kdewebkit-5.3.0.tar.xz"
  sha1 "bfbd77874ea822570a644a868511a8f2ca444477"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
