require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/stable/frameworks/5.0.0/kglobalaccel-5.0.0.tar.xz"
  sha1 "e383ee44510a8bb6fd660bb24497561bcb5da117"
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
