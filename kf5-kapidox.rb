require "formula"

class Kf5Kapidox < Formula
  url "http://download.kde.org/stable/frameworks/5.14/kapidox-5.14.0.tar.xz"
  sha1 "d52d4f6c32a93ed022ef7c318869260595d22bcf"
  homepage "http://www.kde.org/"

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
