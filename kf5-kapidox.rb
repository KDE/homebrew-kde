require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kapidox-5.25.0.tar.xz"
  sha256 "e77283e3b9404b407ee270ea98a54b55d48940a50dadd9b8908c1fd15cc1e82e"
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
