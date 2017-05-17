require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kwallet-5.34.0.tar.xz"
  sha256 "e537d561b536802bd0d881638a6068d8383d1f2497e9ad85c5c596aa746be323"
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
