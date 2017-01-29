require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kpackage-5.30.0.tar.xz"
  sha256 "ca3eb1f8ffbe14e0ed99cc1aaa2d2ef2c77dfa1b4817ea9ac6fc185e94e53bc8"
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
