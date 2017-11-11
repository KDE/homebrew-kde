require "formula"

class Kf5Threadweaver < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/threadweaver-#{version}.tar.xz"
  sha256 "5c116d93f2ca7bdc75db8d59a4b4852d2c7db48073ad3de21e4bfbf6339a2b80"
  desc "High-level multithreading framework"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/threadweaver.git"

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
