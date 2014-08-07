require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.1.0/attica-5.1.0.tar.xz"
  sha1 "1f5678bf53af9f473d588743ce26e694a48df97c"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

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
