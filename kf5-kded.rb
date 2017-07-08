require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kded-5.36.0.tar.xz"
  sha256 "44336777a02273a62c14b4c47dcdf71f3ab2627b46f72b2991eb10d8f3cb8478"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kded.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "qt5"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
