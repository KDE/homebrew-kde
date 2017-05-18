require "formula"

class Kf5Kpty < Formula
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.34/kpty-5.34.0.tar.xz"
  sha256 "a0a4ec1005e97ee295b94a2a977d8d0344c842b40380d50f7176387b3e846502"

  head "git://anongit.kde.org/kpty.git"

  depends_on "cmake" => :build
  depends_on "qt5"
  depends_on "gettext" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "haraldf/kf5/kf5-kcoreaddons" => :build
  depends_on "haraldf/kf5/kf5-kjs" => :build
  depends_on "haraldf/kf5/kf5-ki18n" => :build

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
