require "formula"

class Kf5Kwidgetsaddons < Formula
  desc "Addons to QtWidgets"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kwidgetsaddons-5.39.0.tar.xz"
  sha256 "abb9556d3716beff74460bfea9a33e6470386cb1a68601263b7997a09f1a0db4"

  head "git://anongit.kde.org/kwidgetsaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
