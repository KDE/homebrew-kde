require "formula"

class Kf5Kunitconversion < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kunitconversion-5.37.0.tar.xz"
  sha256 "514b768a1077ad35454859aa8897511dc4aa4ee7b297d86c91caa6bd743078e3"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kunitconversion.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-ki18n"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
