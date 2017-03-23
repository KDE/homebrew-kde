require "formula"

class Kf5Kdesu < Formula
  url "http://download.kde.org/stable/frameworks/5.32/kdesu-5.32.0.tar.xz"
  sha256 "140ebb81d6c3370785ccefce51aa1575824eab38f2dd79f3676b15bf230c5e7f"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kdesu.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kpty"
  depends_on "qt5"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
