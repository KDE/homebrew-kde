require "formula"

class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.08.3/src/libkomparediff2-17.08.3.tar.xz"
  sha256 "ce2d9d7815b4be00e3aa5a4d31dbd44a2d315123d1e5d8a760dacab115016d05"

  head "git://anongit.kde.org/libkomparediff2.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
