require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.32/attica-5.32.0.tar.xz"
  sha256 "e5428cda35021d00baecb16cadf12a08c84ef15e61e72790ae6e33ccef1b749b"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

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
