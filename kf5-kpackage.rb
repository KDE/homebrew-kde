require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.32/kpackage-5.32.0.tar.xz"
  sha256 "79683bf75bff3f897fec2cf2985f62d5ffe8187bb2a2305d00161556a8561f1c"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kpackage.git'

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
