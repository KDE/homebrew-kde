require "formula"

class Kf5Kitemmodels < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kitemmodels-5.38.0.tar.xz"
  sha256 "4cfa7661b6d3c1e242b92c9200383400398af1db341dbbd2de573429898d4068"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kitemmodels.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
