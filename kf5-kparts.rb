require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kparts-5.22.0.tar.xz"
  sha1 "127acef58ff1c5874ca6523e91b2ae484fae4a1f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kparts.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kio"

  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
