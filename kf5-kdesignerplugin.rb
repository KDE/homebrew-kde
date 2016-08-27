require "formula"

class Kf5Kdesignerplugin < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kdesignerplugin-5.25.0.tar.xz"
  sha256 "10b7484e9f5d41d29b776092059f67d128aa373b46413778b8ce8acfdef0aac8"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesignerplugin.git'

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
#  depends_on "haraldf/kf5/kf5-kdewebkit"
  depends_on "haraldf/kf5/kf5-kplotting"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
