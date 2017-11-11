require "formula"

class Kf5Kjobwidgets < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kjobwidgets-5.40.0.tar.xz"
  sha256 "d362616c10d9da48c2c4050930559ea5fb92f4bc10f1bbfb73f1d79386724b54"
  desc "Widgets for tracking KJob instances"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kjobwidgets.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
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
