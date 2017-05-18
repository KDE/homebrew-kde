require "formula"

class Kf5Kwidgetsaddons < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kwidgetsaddons-5.34.0.tar.xz"
  sha256 "cf41801708d7dad4caf6349fba4e19308cabf8fc06de710b7dae96f3623c8843"

  head "git://anongit.kde.org/kwidgetsaddons.git"

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
