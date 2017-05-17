require "formula"

class Kf5Kbookmarks < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kbookmarks-5.34.0.tar.xz"
  sha256 "1bd846dde134d09fccb963d8d3749de6d6b05c9ad11b4c0cbc0241867e26f63d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kbookmarks.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
