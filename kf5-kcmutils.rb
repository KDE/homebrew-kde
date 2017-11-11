require "formula"

class Kf5Kcmutils < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kcmutils-5.40.0.tar.xz"
  sha256 "74310785ffeca567f018c9b2415cd2361a9fae55bdcecdcb9ba8dbb45b945bde"
  desc "Utilities for interacting with KCModules"
  homepage "http://www.kde.org/"

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
