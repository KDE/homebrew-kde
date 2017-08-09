require "formula"

class Kf5Kio < Formula
  url "http://download.kde.org/stable/frameworks/5.36/kio-5.36.0.tar.xz"
  sha256 "f18f51d5d85156de52bf21e7344e06b9fcb6c815043797615171c7a66bb743c8"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kio.git"

  option "without-kiowidgets", "Builds only KIO core"

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt"
  depends_on "haraldf/kf5/kf5-karchive"
  depends_on "haraldf/kf5/kf5-kbookmarks" unless build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kjobwidgets" unless build.without? "kiowidgets"
  depends_on "haraldf/kf5/kf5-kwallet" unless build.without? "kiowidgets"
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
