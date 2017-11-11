require "formula"

class Kf5Kpty < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kpty-5.40.0.tar.xz"
  sha256 "e708f716724cfc476ba9c2da678d24bf1654d8ac47b3eaf87fe3990c656bb4e4"
  desc "Pty abstraction"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpty.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons" => :build
  depends_on "KDE-mac/kde/kf5-kjs" => :build
  depends_on "KDE-mac/kde/kf5-ki18n" => :build
  depends_on "qt"
  depends_on "gettext" => :build

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
