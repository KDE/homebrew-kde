require "formula"

class Kf5Kplotting < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kplotting-5.37.0.tar.xz"
  sha256 "fc837e0f21a6acbcff6b44d1c8b2143737bdc813839af0ea0a30550937069a4c"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kplotting.git"

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
