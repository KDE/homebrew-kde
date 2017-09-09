require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kidletime-5.38.0.tar.xz"
  sha256 "5bd30a316ea72a44ed4e4f7f11533e5aa74fc817f360f471b2658ac560e221c5"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kidletime.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
