require "formula"

class Kf5Kglobalaccel < Formula
  url "http://download.kde.org/unstable/frameworks/4.97.0/kglobalaccel-4.97.0.tar.xz"
  sha1 "de5a76abc88011b1f84d1d1817ac30da1c2bce04"

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
