require "formula"

class Kf5Kparts < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kparts-5.25.0.tar.xz"
  sha256 "ea187dc45376b53818bf76ed794c988b7793ae21f2683ce010cba995a31b92e3"
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
