require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.10/kwallet-5.10.0.tar.xz"
  sha1 "a23e1569dbd21ebe11ba0b4213db2de88a9251d1"
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
