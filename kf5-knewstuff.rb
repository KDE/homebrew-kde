require "formula"

class Kf5Knewstuff < Formula
  url "http://download.kde.org/stable/frameworks/5.38/knewstuff-5.38.0.tar.xz"
  sha256 "4052f0ac27bc32de02493494816809261e762eeb2e906168d9e749aa99ab8cd0"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/knewstuff.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
