require "formula"

class Kf5Kdbusaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kdbusaddons-5.10.0.tar.xz"
  sha1 "010a7d272f8c8c3b917027677cadc70632372c4c"
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
