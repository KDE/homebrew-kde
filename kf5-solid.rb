require "formula"

class Kf5Solid < Formula
  url "http://download.kde.org/stable/frameworks/5.1.0/solid-5.1.0.tar.xz"
  sha1 "d6a9f8055296bc15242e777ad3c11ed12325d68f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/solid.git'

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
