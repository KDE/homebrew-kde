require "formula"

class Kf5Knewstuff < Formula
  url "http://download.kde.org/stable/frameworks/5.34/knewstuff-5.34.0.tar.xz"
  sha256 "02ad34252a5205824cbee79752593e09adfd8b3992cca712fd4da4cca91fa5a5"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/knewstuff.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  depends_on "haraldf/kf5/kf5-kio"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
