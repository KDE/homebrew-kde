require "formula"

class Kf5Kdbusaddons < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kdbusaddons-5.34.0.tar.xz"
  sha256 "d058f83edef52e47abd112e43ef88c5ab0e505d3133abd158f7e41695da76bea"

  head "git://anongit.kde.org/kdbusaddons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "shared-mime-info"
  depends_on "d-bus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
