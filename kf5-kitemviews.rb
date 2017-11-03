require "formula"

class Kf5Kitemviews < Formula
  desc "Widget addons for Qt Model/View"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kitemviews-5.39.0.tar.xz"
  sha256 "d069da87a28b373676b7bda1a1474c5f8c815441041cbc5af52d7c1a5a4a885e"

  head "git://anongit.kde.org/kitemviews.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

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
