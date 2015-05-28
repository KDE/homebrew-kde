require "formula"

class Kf5Kbookmarks < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kbookmarks-5.10.0.tar.xz"
  sha1 "587e4dcb7325d81d80b023d0027fe99f615cb313"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kbookmarks.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
