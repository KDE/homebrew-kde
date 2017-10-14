require "formula"

class Kf5Kross < Formula
  url "http://download.kde.org/stable/frameworks/5.39/portingAids/kross-5.39.0.tar.xz"
  sha256 "d06ddc6157e150ea91be0f790df35a2e14239de0179f0cd8f048ad93597c09be"
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
