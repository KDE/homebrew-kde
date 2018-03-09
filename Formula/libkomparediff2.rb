class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/17.12.3/src/libkomparediff2-17.12.3.tar.xz"
  sha256 "f470296f4e1bd9529e9d7372e86d47e504c8e9417a74f031f1c766513745d770"
  revision 1

  head "git://anongit.kde.org/libkomparediff2.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kio"

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
