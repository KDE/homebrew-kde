require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kdesu-5.30.0.tar.xz"
  sha256 "b3a265811f09048f45232af3a75b734c57b38a1b22be97e8d1290d72d535d4b2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt5"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
