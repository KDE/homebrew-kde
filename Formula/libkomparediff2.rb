class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/release-service/20.04.0/src/libkomparediff2-20.04.0.tar.xz"
  sha256 "a4f0d91a274bbc7e7a47d428be5e252750d081499c2e2514b8691a051aaa35f5"
  head "git://anongit.kde.org/libkomparediff2.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"

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

  test do
    (testpath/"CMakeLists.txt").write("find_package(LibKompareDiff2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
