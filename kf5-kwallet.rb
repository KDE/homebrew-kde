require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.6/kwallet-5.6.0.tar.xz"
  sha1 "1a0e5c95f2ba72d71c7b66d52f97e03fe8ee8878"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwallet.git'

  depends_on "libgcrypt"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"
  depends_on "haraldf/kf5/kf5-knotifications"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
