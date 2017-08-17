require "formula"

class Kf5Kiconthemes < Formula
  url "http://download.kde.org/stable/frameworks/5.37/kiconthemes-5.37.0.tar.xz"
  sha256 "b83bc856947134d4c7a97a6bf8f61045269fb614d6f7d482b344a8beb57bf5c8"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kiconthemes.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "qt"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
