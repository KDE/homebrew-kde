require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kapidox-5.22.0.tar.xz"
  sha256 "a1550820460f50e5a260e654d081e53c964b022b73ffe377cb6ced1cde184133"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kapidox.git'

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
