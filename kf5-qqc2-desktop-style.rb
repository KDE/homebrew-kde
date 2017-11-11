require "formula"

class Kf5Qqc2DesktopStyle < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/qqc2-desktop-style-#{version}.tar.xz"
  sha256 "fb8818b22dbc1f47c38bef488543f025ec5da810e84f5ed732b08969338411e1"
  desc "A style for Qt Quick Controls 2 to make it follow your desktop theme"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/qqc2-desktop-style.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kirigami2" => :build
  depends_on "KDE-mac/kde/kf5-kiconthemes" => :build
  depends_on "KDE-mac/kde/kf5-kconfigwidgets" => :build

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
