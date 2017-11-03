require "formula"

class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.08.2/src/libkomparediff2-17.08.2.tar.xz"
  sha256 "00690ec08490cac26e5d1899041b961eb5980dc5b15970b2b6b09d2da0078075"

  head "git://anongit.kde.org/libkomparediff2.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-ki18n"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
