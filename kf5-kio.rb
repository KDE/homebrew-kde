require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.32/kio-5.32.0.tar.xz"
  sha256 "364adf30d1df6f52d5960061d4c21e91519dfa8674ae95fa01144805a800aaa5"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kio.git'

  option "without-kiowidgets", "Builds only KIO core"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks" if not build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kjobwidgets" if not build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kwallet" if not build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-solid"
  depends_on "haraldf/kf5/kf5-kservice"

  def install
    args = std_cmake_args
    args << "-DKIOCORE_ONLY=ON" if build.without? "kiowidgets"

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
