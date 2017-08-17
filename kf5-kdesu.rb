require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kdesu-5.37.0.tar.xz"
  sha256 "ea37e8517ab376f86c9d7df726f0f8f143fac198c6a3a6a26f2e276ae69fd0e1"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdesu.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
