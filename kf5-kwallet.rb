require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kwallet-5.22.0.tar.xz"
  sha1 "e3f122cdb642937009ecc4f2c8d6718a2f19bb19"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kwallet.git'

  depends_on "libgcrypt"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-knotifications"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
