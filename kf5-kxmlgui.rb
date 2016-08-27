require "formula"

class Kf5Kxmlgui < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kxmlgui-5.25.0.tar.xz"
  sha256 "1ff1f07fc1bede0cb0b498de2d2b0db088639b91d0f7c39a90abfc032dbb44b2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kxmlgui.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kglobalaccel"
  depends_on "haraldf/kf5/kf5-ktextwidgets"
  depends_on "haraldf/kf5/kf5-attica"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
