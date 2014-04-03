require "formula"

class Kf5Kdesignerplugin < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kdesignerplugin-4.97.0.tar.xz"
  sha1 "2c8f05924b356040f26cac42afa0b8f7270a115a"
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
