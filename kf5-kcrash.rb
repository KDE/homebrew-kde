require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.39/kcrash-5.39.0.tar.xz"
  sha256 "9a0727734745b3050f864f2de1dbdb91e9ac99a49ede9874613427080a1563bb"
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
