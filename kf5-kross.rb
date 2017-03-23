require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.32/portingAids/kross-5.32.0.tar.xz"
  sha256 "aa70eb77bdfa5c4df38a925581fc07bdad8f3f0e77b21f3204f74397c562f155"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kross.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
