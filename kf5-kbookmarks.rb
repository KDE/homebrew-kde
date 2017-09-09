require "formula"

class Kf5Kbookmarks < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kbookmarks-5.38.0.tar.xz"
  sha256 "38af8bb592a323b05d05b72d22b9bd5d48932a01e86941fec5e0e5ca59054368"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kbookmarks.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
