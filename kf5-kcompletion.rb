require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kcompletion-5.36.0.tar.xz"
  sha256 "377103eb36855e0bb971fc22c974f85792ee71a73e6705725047ccfe337320f2"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcompletion.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
