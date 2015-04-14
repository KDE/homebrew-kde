require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.9/portingAids/kross-5.9.0.tar.xz"
  sha1 "8d7c97ab4c4ee14b4c5be4b84d1021ca1c872744"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kross.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
