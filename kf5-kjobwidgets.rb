require "formula"

class Kf5Kjobwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.38/kjobwidgets-5.38.0.tar.xz"
  sha256 "a5340df37ba44f6b5b82f8c6732aaaa42ffc6d9a829c15b345e824360eb3e66e"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kjobwidgets.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons"
  depends_on "haraldf/kf5/kf5-kwidgetsaddons"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
