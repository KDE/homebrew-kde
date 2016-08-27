require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kcrash-5.25.0.tar.xz"
  sha256 "a84a9a5b73c51678d84cfe9d87a945f992e6035a9dbd29040bbe5dbcfd38ba6e"
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
