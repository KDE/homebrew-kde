class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/release-service/19.12.2/src/libkomparediff2-19.12.2.tar.xz"
  sha256 "ad17a6b9f9c128cd29380c9ce777a2a336db8f9d3e7a715f057587a06dc0d6e2"

  head "git://anongit.kde.org/libkomparediff2.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
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
