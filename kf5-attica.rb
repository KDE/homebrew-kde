require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.25/attica-5.25.0.tar.xz"
  sha256 "951af772a83237d2c0c9a7fede2608101041d2cc13716221c97d9c79cc79e5be"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
