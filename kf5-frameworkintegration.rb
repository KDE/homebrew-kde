require "formula"

class Kf5Frameworkintegration < Formula
  url "https://download.kde.org/stable/frameworks/5.40/frameworkintegration-5.40.0.tar.xz"
  sha256 "b277f644d9b33fcf7026d13106646366661cdcd37df5f5bc623e47143a0488e4"
  desc "Framework providing components to allow applications to integrate with a KDE Workspace"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/frameworkintegration.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kpackage"
  depends_on "KDE-mac/kde/kf5-knewstuff"

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
