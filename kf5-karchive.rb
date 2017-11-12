require "formula"

class Kf5Karchive < Formula
  url "https://download.kde.org/stable/frameworks/5.40/karchive-5.40.0.tar.xz"
  sha256 "1e181495390ba730f2b1aa9354da2122e2aa592aaffdbce4164fd9dcb2d97bb1"
  desc "Qt 5 addon providing access to numerous types of archives"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/karchive.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "zlib"
  depends_on "bzip2"

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
