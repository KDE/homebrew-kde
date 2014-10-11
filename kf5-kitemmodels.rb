require "formula"

class Kf5Kitemmodels < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kitemmodels-5.3.0.tar.xz"
  sha1 "396693b7ec5d738aa870b363fb33b0e0cdeb6365"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemmodels.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
