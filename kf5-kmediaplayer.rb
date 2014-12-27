require "formula"

class Kf5Kmediaplayer < Formula
  url "http://download.kde.org/stable/frameworks/5.5/portingAids/kmediaplayer-5.5.0.tar.xz"
  sha1 "c8a7957afea846fba6a11a2da1fa1904a9acfa91"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
