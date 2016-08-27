require "formula"

class Kf5Frameworkintegration < Formula
  url "http://download.kde.org/stable/frameworks/5.25/frameworkintegration-5.25.0.tar.xz"
  sha256 "ea9ccb564aa1cebdd7ad3dbd5168cb1ae750f20122918864d846990828057653"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/frameworkintegration.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
  end
end
