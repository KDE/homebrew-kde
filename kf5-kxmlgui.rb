require "formula"

class Kf5Kxmlgui < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kxmlgui-5.34.0.tar.xz"
  sha256 "3e8e9232146915fd3afbc8780a17fb2ece11dc3a23cea24860713c2c3f3615ed"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kxmlgui.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kglobalaccel"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-attica"
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
