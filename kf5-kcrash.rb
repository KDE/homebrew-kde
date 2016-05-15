require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.22/kcrash-5.22.0.tar.xz"
  sha1 "fe5d42140e1979c81efc4d754463f32a74dbbb61"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcrash.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kcoreaddons"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
