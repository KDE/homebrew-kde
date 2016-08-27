require "formula"

class Kf5Kcompletion < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kcompletion-5.25.0.tar.xz"
  sha256 "6a8af0a084ce697f57382f16157b0c21e4287c809819611fb7e6171e7e149d4a"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcompletion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
