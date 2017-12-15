class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/17.12.0/src/libkomparediff2-17.12.0.tar.xz"
  sha256 "b81eb715ba36f9dbe1d02215c9fb7b7177d5e22f9ae023b273393b2377e1907a"
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
