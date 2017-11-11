require "formula"

class Kf5Kwidgetsaddons < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kwidgetsaddons-#{version}.tar.xz"
  sha256 "abb9556d3716beff74460bfea9a33e6470386cb1a68601263b7997a09f1a0db4"
  desc "Addons to QtWidgets"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwidgetsaddons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

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
