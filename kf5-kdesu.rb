require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kdesu-5.25.0.tar.xz"
  sha256 "13c94cb501fc3abdeec23bd133ef1f7c875f6c56951e8755593a791b6a24e305"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt5" => "with-dbus"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
