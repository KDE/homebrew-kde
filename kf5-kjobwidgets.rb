require "formula"

class Kf5Kjobwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kjobwidgets-5.25.0.tar.xz"
  sha256 "4ecd09af1df430110da6607fabb0aa5231f89b3cff0b1477438c899d5d4204d8"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kjobwidgets.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
