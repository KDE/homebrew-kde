require "formula"

class Kf5Kdbusaddons < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kdbusaddons-4.98.0.tar.xz"
  sha1 "d002c8df84a4e6bc6205042c75f5cce363d4bf81"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdbusaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "shared-mime-info"
  depends_on "d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
