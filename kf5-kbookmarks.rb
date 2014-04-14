require "formula"

class Kf5Kbookmarks < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kbookmarks-4.98.0.tar.xz"
  sha1 "7d1532313cf9f60f25da46b100193e2b8cf62cbf"

  head 'git://anongit.kde.org/kbookmarks.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kxmlgui"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
