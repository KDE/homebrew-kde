require "formula"

class Kf5Threadweaver < Formula
  url "http://download.kde.org/stable/frameworks/5.36/threadweaver-5.36.0.tar.xz"
  sha256 "a15e52811fbc710a618e060c3f7f7cb4623805c83e8a5b24d9f326b55a3be9a7"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/threadweaver.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
