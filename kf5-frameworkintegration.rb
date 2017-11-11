require "formula"

class Kf5Frameworkintegration < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/frameworkintegration-#{version}.tar.xz"
  sha256 "50b427b53dfdf667d3e6d8de2b1662a7bea508cbf361163f0383a9e82143da8c"
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
