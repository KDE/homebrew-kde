require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.32/kapidox-5.32.0.tar.xz"
  sha256 "bc69f03937c6de51cb5f036601627a746d991986fdde6c159bb8667eaf6ed0fc"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kapidox.git'

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
