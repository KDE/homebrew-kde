require "formula"

class Kf5Kpty < Formula
  url "http://download.kde.org/stable/frameworks/5.39/kpty-5.39.0.tar.xz"
  sha256 "16d26608a7bb5feb085aba7162e6d0ed151f1aace6fbdf7c68a8ccc1c76b060a"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpty.git"

  depends_on "cmake" => :build
  depends_on "qt"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons" => :build
  depends_on "haraldf/kf5/kf5-kjs" => :build
  depends_on "haraldf/kf5/kf5-ki18n" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
