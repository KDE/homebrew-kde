require "formula"

class Kf5Kmediaplayer < Formula
  url "http://download.kde.org/stable/frameworks/5.25/portingAids/kmediaplayer-5.25.0.tar.xz"
  sha256 "ae234e7f03b791be27e1c59a55eab96712570e9aedcb15d00eadc3b52ccb92e1"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
