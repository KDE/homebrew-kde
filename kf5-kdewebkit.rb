require "formula"

class Kf5Kdewebkit < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kdewebkit-5.5.0.tar.xz"
  sha1 "af2e2079a5a9aa5699284ddfc36433b7a9f6e858"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/attica.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt5" => "with-d-bus"

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
