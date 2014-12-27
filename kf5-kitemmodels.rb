require "formula"

class Kf5Kitemmodels < Formula
  url "http://download.kde.org/stable/frameworks/5.5/kitemmodels-5.5.0.tar.xz"
  sha1 "02503886b8fa2edc6d49b8dfa4a607f84f5eb997"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kitemmodels.git'

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
