require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.30/portingAids/kross-5.30.0.tar.xz"
  sha256 "bfab8313f0f1b121e3fd61d0537efe6fa3cd7004121eed1c42eca09c9dfd0eaf"
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
