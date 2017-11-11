require "formula"

class Kf5Kbookmarks < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kbookmarks-#{version}.tar.xz"
  sha256 "e51b6e9551b649bbfadd95f40b0ae46e197a8bdaa051ccc10db17678985fcaf5"
  desc "Support for bookmarks and the XBEL format"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kbookmarks.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kxmlgui"

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
