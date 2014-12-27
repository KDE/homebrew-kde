require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.5/threadweaver-5.5.0.tar.xz"
  sha1 "868e024fa227305113c8d4f9daed8207193d90a1"
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
