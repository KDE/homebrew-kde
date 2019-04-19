class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/19.04.0/src/libkexiv2-19.04.0.tar.xz"
  sha256 "9fcafa932631429af1693642415d2f202ad29338b63949b5e8661135eb69dc19"

  head "git://anongit.kde.org/libkexiv2.git"
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "exiv2"
  depends_on "qt"

  patch do
    # Fix build with Exiv2 0.27
    url "https://github.com/KDE/libkexiv2/commit/d1be9298c7f2b9c717cda154d41732f230ea13a6.patch?full_index=1"
    sha256 "8fc831c6918b7a274de1fa7737dd678d127299552f3e564a110d58898ae8af17"
  end
  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
