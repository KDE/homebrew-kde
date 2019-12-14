class Libkomparediff2 < Formula
  desc "Library to compare files and strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/release-service/19.12.0/src/libkomparediff2-19.12.0.tar.xz"
  sha256 "39335b1b31dcac243df5543d4eaa5e230a262e23cd045c9e645e05079672001e"

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
