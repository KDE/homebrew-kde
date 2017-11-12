require "formula"

class Libkexiv2 < Formula
  url "https://download.kde.org/stable/applications/17.08.3/src/libkexiv2-17.08.3.tar.xz"
  sha256 "220b0c86132b84a32a674bf404174a51419a3ea40f4f7096541a0c39cc342049"
  desc "A library to manipulate pictures metadata"
  homepage "http://www.kde.org/"

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
