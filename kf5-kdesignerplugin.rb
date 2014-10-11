require "formula"

class Kf5Kdesignerplugin < Formula
  url "http://download.kde.org/stable/frameworks/5.3.0/kdesignerplugin-5.3.0.tar.xz"
  sha1 "a93f2b56adf559a960f8483f534c747b26509d7d"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesignerplugin.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kdewebkit"
  depends_on "haraldf/kf5/kf5-kplotting"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
