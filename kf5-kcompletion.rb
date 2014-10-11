require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kcompletion-5.3.0.tar.xz"
  sha1 "85586cc4246aeed381ec5beca324377aeafca80c"
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
