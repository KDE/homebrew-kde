require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kcrash-5.38.0.tar.xz"
  sha256 "215c90bf6501cb90db01f2a04155bcd8a8e66fcfb4a94649e72204c5a1df10a9"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcrash.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  depends_on "haraldf/kf5/kf5-kwindowsystem"
  depends_on "haraldf/kf5/kf5-kcoreaddons"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
