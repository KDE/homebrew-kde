require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kparts-5.38.0.tar.xz"
  sha256 "f7a701a02d89c5555d92047760314c64fd51beb13ed393ebee67597e13396aa5"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kparts.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kio"

  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
