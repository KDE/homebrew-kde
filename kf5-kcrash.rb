require "formula"

class Kf5Kcrash < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kcrash-5.34.0.tar.xz"
  sha256 "e3cee5a562070728e5b7ad82e3924ef80151756abb206c85810f2fd88e5750b3"

  head "git://anongit.kde.org/kcrash.git"

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
