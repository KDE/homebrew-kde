require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kidletime-5.25.0.tar.xz"
  sha256 "4d430e6c345893df892a701a9cfab48c704057e3e18e65abec8014a05069576f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kidletime.git'

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
