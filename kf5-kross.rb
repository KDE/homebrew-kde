require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.22/portingAids/kross-5.22.0.tar.xz"
  sha256 "94c8c628171672ccba9455b342a43eb21f5be22ebb1a0f9195576f03144c6ac6"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kross.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
