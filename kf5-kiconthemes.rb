require "formula"

class Kf5Kiconthemes < Formula
  url "http://download.kde.org/stable/frameworks/5.34/kiconthemes-5.34.0.tar.xz"
  sha256 "312a3d76ba42d2b8f4e959f42e7dc1f33363529fb2279b76820d316cb2407441"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kiconthemes.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
