require "formula"

class Kf5Kimageformats < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kimageformats-5.25.0.tar.xz"
  sha256 "e458c182338331c2617372876ddc24984886c006e5bba425261e0dc5621375be"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kimageformats.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "openexr"
  depends_on "jasper"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
