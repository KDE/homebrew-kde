require "formula"

class Kf5Alkimia < Formula
  desc "Library used by KDE Finance applications"
  homepage "http://kmymoney.org/"

  head "git://anongit.kde.org/alkimia.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "gmp"
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
