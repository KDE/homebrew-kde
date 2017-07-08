require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kcrash-5.36.0.tar.xz"
  sha256 "2d8edd9813b8543cef68cd6cf09c85195999d06f9b06ed0803707a1c925eda38"
  homepage "http://www.kde.org/"

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
