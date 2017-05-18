require "formula"

class Kf5Kwindowsystem < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kwindowsystem-5.34.0.tar.xz"
  sha256 "035190f599d7ff5718b2254dd9cb4100a22f69cd1e8bdb60dd2970e8d4e9e2ea"

  head "git://anongit.kde.org/kwindowsystem.git"

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
