require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kunitconversion-4.98.0.tar.xz"
  sha1 "d0e8096af2c67f1699c8e80ee68e3fe878e9e14d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kunitconversion.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-kjs"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kconfig"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
