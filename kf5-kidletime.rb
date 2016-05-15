require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kidletime-5.22.0.tar.xz"
  sha256 "ec7a59dcc96bab3f8efde24ffcde3061855e34db57aeab5b0fe373636306fc35"
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
