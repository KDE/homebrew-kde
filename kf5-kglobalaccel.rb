require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/kglobalaccel-4.98.0.tar.xz"
  sha1 "3c0b7bb8754e8535534c319ede91e8fe31d1c052"
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
