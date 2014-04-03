require "formula"

class Kf5Kjobwidgets < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kjobwidgets-4.97.0.tar.xz"
  sha1 "1b23ac197153f75d0b37893da62b419a70de91dc"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kjobwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
