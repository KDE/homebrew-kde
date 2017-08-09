require "formula"

class Kf5Kactivities < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kactivities-5.36.0.tar.xz"
  sha256 "47eb6967336d4d985b079e5b5b44afc51d66e7ed3a85cea923e295e10a952340"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kactivities.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-kconfig"
  depends_on "haraldf/kf5/kf5-kdeclarative"
  depends_on "haraldf/kf5/kf5-kdbusaddons"
  depends_on "haraldf/kf5/kf5-ki18n"
  depends_on "haraldf/kf5/kf5-kcmutils"
  depends_on "boost"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
