require "formula"

class Kf5Kpty < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kpty-5.38.0.tar.xz"
  sha256 "de98c5e8c13135aee4038b53b7656d8dad88e6a652140390608fdedc2344f031"
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
