require "formula"

class Kf5Kiconthemes < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kiconthemes-5.25.0.tar.xz"
  sha256 "dfea9b4da835c028b62faec6550d279a3a75874ff88d996d2b603be4f9b228b5"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kiconthemes.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kconfigwidgets"
  depends_on "haraldf/kf5/kf5-kitemviews"
  depends_on "qt5" => "with-dbus"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
