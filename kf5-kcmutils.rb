require "formula"

class Kf5Kcmutils < Formula
  desc "Utilities for interacting with KCModules"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/kcmutils-5.39.0.tar.xz"
  sha256 "80375a266286ec20b2c035ad3a79fe7aa4fe0974156413e8d7a9c881a482e4b3"

  head "git://anongit.kde.org/kcmutils.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kf5-kdeclarative"
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
