require "formula"

class Kf5Kbookmarks < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kbookmarks-5.25.0.tar.xz"
  sha256 "0190db136a1d2c8d6065aa3e01fc64a9753c1f7a6a6fd43c3250ea9831097137"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kbookmarks.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
