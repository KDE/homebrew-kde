require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/unstable/frameworks/4.98.0/attica-4.98.0.tar.xz"
  sha1 "3dca0588c76a6ff129cc2dd15e8aebdd278c51ea"

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
