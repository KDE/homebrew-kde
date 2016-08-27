require "formula"

class Kf5Kded < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kded-5.25.0.tar.xz"
  sha256 "69128b448e542a68911cdfcc82c566e31d5c9af0e20c051490223719953f5ed8"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kded.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kinit"
  depends_on "qt5" => "with-dbus"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
