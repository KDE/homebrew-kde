require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.7/attica-5.7.0.tar.xz"
  sha1 "b5882fd95b867a0d74574bf90111a6c530506324"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
