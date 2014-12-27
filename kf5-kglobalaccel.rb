require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kglobalaccel-5.5.0.tar.xz"
  sha1 "754c1604f82d6c8daf8377fb0eea91e3313053d2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kglobalaccel.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
