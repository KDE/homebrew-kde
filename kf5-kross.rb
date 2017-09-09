require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.38/portingAids/kross-5.38.0.tar.xz"
  sha256 "670dc18d258e8f821fcd64ba30c587ac3afaecbc54d968edb0fe624682788cb5"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kross.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kdoctools" => :build
  depends_on "haraldf/kf5/kf5-kparts"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
