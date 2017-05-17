require "formula"

class Kf5Kitemmodels < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kitemmodels-5.34.0.tar.xz"
  sha256 "05a72132df6001069273cc1425d65e890edf8112ac88cd2c6b61f5a3ee0d38d2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemmodels.git'

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
