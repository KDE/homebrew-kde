require "formula"

class Kf5Kpty < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kpty-5.37.0.tar.xz"
  sha256 "aab4ff0a6025e6dab859ce74a5cbf7031c52fe8674740c7408f1311ff2386871"
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
