require "formula"

class Kf5Kdesignerplugin < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kdesignerplugin-4.98.0.tar.xz"
  sha1 "f8e256dd0b66380371db895edc3598b4f761053c"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesignerplugin.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kdoctools"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
