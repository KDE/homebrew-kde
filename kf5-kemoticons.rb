require "formula"

class Kf5Kemoticons < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kemoticons-5.36.0.tar.xz"
  sha256 "aecc1537cc03124ccc6f9f625424ec96d0904afe800c411a84dab5233a7a8a2f"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kemoticons.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"

  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kservice"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
