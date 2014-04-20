require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kcompletion-4.98.0.tar.xz"
  sha1 "11500a132a78d21aa075f3eb72e32840c71358d6"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcompletion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
