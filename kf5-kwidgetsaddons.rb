require "formula"

class Kf5Kwidgetsaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kwidgetsaddons-5.5.0.tar.xz"
  sha1 "77545c7afea6cb6191df4441cab7f2fdaa62f836"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwidgetsaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
