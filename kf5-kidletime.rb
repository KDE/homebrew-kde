require "formula"

class Kf5Kidletime < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kidletime-5.37.0.tar.xz"
  sha256 "3a472778722f38e5175ac55ff71a5e464ec98ecfd2ec759b7003612fe8c0a406"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kidletime.git"

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
