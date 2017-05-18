require "formula"

class Kf5Kidletime < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kidletime-5.34.0.tar.xz"
  sha256 "8f08be04214fb9cc0ef1bf463d8f577f72ddbdc2048bab29455578517e341d7d"

  head "git://anongit.kde.org/kidletime.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
