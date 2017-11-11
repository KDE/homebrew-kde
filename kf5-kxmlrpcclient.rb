require "formula"

class Kf5Kxmlrpcclient < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kxmlrpcclient-#{version}.tar.xz"
  sha256 "faa3e3af7b85c3bf679fc991d5ff2ef3c4f068a7e516885215c6d2e6870d8ac8"
  desc "XML-RPC client library for KDE"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kxmlrpcclient.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kio"

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
