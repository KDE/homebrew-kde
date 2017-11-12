require "formula"

class Kf5SyntaxHighlighting < Formula
  url "https://download.kde.org/stable/frameworks/5.40/syntax-highlighting-5.40.0.tar.xz"
  sha256 "148dd0d3d091ad5ee352cc528f494a375d89d2812ff31b08c735e0929a358075"
  desc "Syntax highlighting engine for structured text and code"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/syntax-highlighting.git"

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
