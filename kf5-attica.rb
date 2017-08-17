require "formula"

class Kf5Attica < Formula
  url "http://download.kde.org/stable/frameworks/5.37/attica-5.37.0.tar.xz"
  sha256 "573c71704b4116e82a9866a86b90e375a1f5022563246b14bb0866963899588e"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

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
