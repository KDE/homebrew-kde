require "formula"

class Kf5Kdiagram < Formula
  desc "Powerful libraries for creating business diagrams"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdiagram.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
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
