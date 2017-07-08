require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kpackage-5.36.0.tar.xz"
  sha256 "0887882000eeef5c12bb613672075187b1f031e8d87dbaecdadc02c9112a8a2f"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpackage.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
