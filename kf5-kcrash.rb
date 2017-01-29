require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.30/kcrash-5.30.0.tar.xz"
  sha256 "04a22615e03dc9db29daccfc437fd6d952e35b3dd39f52d95ea24115037aac42"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kcrash.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kcoreaddons"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
