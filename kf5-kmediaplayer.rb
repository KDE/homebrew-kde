require "formula"

class Kf5Kmediaplayer < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/portingAids/kmediaplayer-5.34.0.tar.xz"
  sha256 "06cd8108f12a367a296896e8365327170721dad5f970a215e4bb69831c3e08d7"

  head "git://anongit.kde.org/attica.git"

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
