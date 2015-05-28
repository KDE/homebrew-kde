require "formula"

class Kf5Knewstuff < Formula
  url "http://download.kde.org/stable/frameworks/5.10/knewstuff-5.10.0.tar.xz"
  sha1 "a5e80a8b73867a52739e821071ffe8a39327ff83"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/knewstuff.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
