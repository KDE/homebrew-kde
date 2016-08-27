require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kwidgetsaddons-5.25.0.tar.xz"
  sha256 "1e099d9e021dc44fdee54220b30d3f48a72900fa88e8273ee7fea2895946a8bd"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwidgetsaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
