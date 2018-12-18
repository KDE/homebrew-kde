class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/18.12.0/src/libkexiv2-18.12.0.tar.xz"
  sha256 "0a862feb9d9238f1b8b8a6c95d2ee7744145605239bfba024376021323eb77f4"

  head "git://anongit.kde.org/libkexiv2.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "exiv2"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
