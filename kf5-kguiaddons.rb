require "formula"

class Kf5Kguiaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kguiaddons-5.38.0.tar.xz"
  sha256 "01a6350be86f86fb11625393fdc2cb1fe70b7289d06140afa7b0186339047aca"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kguiaddons.git"

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
