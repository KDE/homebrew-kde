require "formula"

class Kf5Kpackage < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kpackage-5.22.0.tar.xz"
  sha256 "73054d30219c54578984751b1505c03a68eaf1a0b4d4c99a8e51386409937cd9"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kpackage.git'

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
