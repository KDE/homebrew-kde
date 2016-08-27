require "formula"

class Kf5Kdbusaddons < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kdbusaddons-5.25.0.tar.xz"
  sha256 "3db7b90f37ac78c813e2554ce48591b3535732207b1c94deed3a13aea554132e"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdbusaddons.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "shared-mime-info"
  depends_on "d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
