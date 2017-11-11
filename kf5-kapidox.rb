require "formula"

class Kf5Kapidox < Formula
  version "5.39.0"
  url "https://download.kde.org/stable/frameworks/#{version}/kapidox-#{version}.tar.xz"
  sha256 "d6701d35aa45b65dbf442d3325416c3100aa317a94fbeeb8f25595c782d2d58a"
  desc "Frameworks API Documentation Tools"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kapidox.git"

  depends_on "cmake" => :build
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
