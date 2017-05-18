require "formula"

class Kf5Kpackage < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kpackage-5.34.0.tar.xz"
  sha256 "b8f09869323f5d077da750f982d7de800897a66366fc66d559fd3d9919acbe71"

  head "git://anongit.kde.org/kpackage.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
