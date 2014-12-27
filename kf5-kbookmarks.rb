require "formula"

class Kf5Kbookmarks < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kbookmarks-5.5.0.tar.xz"
  sha1 "d17cb62871b8d8dc7965d59e1b03242ef8168180"
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
