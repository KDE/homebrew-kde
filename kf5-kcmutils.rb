require "formula"

class Kf5Kcmutils < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kcmutils-5.38.0.tar.xz"
  sha256 "0b15971ece6003636d012e37760324b005b06050d4d076bbe30eed427717ce58"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcmutils.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "haraldf/kf5/kf5-kdeclarative"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
