require "formula"

class Libkexiv2 < Formula
  desc "A library to manipulate pictures metadata"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/applications/17.08.2/src/libkexiv2-17.08.2.tar.xz"
  sha256 "d1f86afd77d722818c7656d793e7026180ecc95fcc8b522d4ff334333ce2a108"

  head "git://anongit.kde.org/libkexiv2.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "exiv2"

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
