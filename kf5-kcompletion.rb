require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kcompletion-5.5.0.tar.xz"
  sha1 "0dc78ba5e492b82b9bdd98af4c14028aba87a83d"
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
