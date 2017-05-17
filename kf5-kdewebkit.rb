require "formula"

class Kf5Kdewebkit < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kdewebkit-5.34.0.tar.xz"
  sha256 "93a76bc865c813e6607e93a8cd07ba0b8ccd12a590d032680d58921557b1b994"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
