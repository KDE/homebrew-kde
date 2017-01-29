require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kwallet-5.30.0.tar.xz"
  sha256 "93140adf0b48c45d1867ae0927484fda0e0b33c5247fa27fadb2f063d903ccda"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwallet.git'

  depends_on "libgcrypt"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-knotifications"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
