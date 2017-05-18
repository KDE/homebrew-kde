require "formula"

class Kf5Ktextwidgets < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/ktextwidgets-5.34.0.tar.xz"
  sha256 "fc15f146da7f7fb1b758cb8213e62d609e53ad881493b05fe17c8d33161931c3"

  head "git://anongit.kde.org/ktextwidgets.git"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcompletion"
  depends_on "haraldf/kf5/kf5-kiconthemes"
  depends_on "haraldf/kf5/kf5-kservice"
  depends_on "haraldf/kf5/kf5-sonnet"
  depends_on "qt5"

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
