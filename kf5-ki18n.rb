require "formula"

class Kf5Ki18n < Formula
  desc "Advanced internationalization framework"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/ki18n-5.39.0.tar.xz"
  sha256 "5e31cac2735db66de620d28a5d561f15aaafd6181c1ff7ca3a03b20ce3c305a5"

  head "git://anongit.kde.org/ki18n.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl" # cmake thinks libintl is part of libc
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
