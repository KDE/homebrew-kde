require "formula"

class Kf5Kplotting < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kplotting-#{version}.tar.xz"
  sha256 "6ad90a3c774cec102dee21d63ba8b4d75b5bc95d61cf903480f11a3b840b3eb6"
  desc "Lightweight plotting framework"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kplotting.git"

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
