require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kwallet-5.22.0.tar.xz"
  sha256 "68a0415364235d38cb58d19accfba5a6e384b269fbb88d3caf3cb6f9c29d40c4"
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
