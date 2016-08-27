require "formula"

class Kf5Kcoreaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kcoreaddons-5.25.0.tar.xz"
  sha256 "5479180bcb6034cfcfbe779d88d91e11233f2120ba6314d180a1f87ad3f02c09"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcoreaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "shared-mime-info"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
