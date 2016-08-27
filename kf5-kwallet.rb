require "formula"

class Kf5Kwallet < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kwallet-5.25.0.tar.xz"
  sha256 "def7a27d609b79f41775093d5ff2629146396010610ce7d0ff9a52ffedec01e1"
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
