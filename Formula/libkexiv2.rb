class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/19.04.3/src/libkexiv2-19.04.3.tar.xz"
  sha256 "b0c5da0e23e93a218f7e96f98a753b36e2d608e74ac68c687ae868b6de99d1e6"

  head "git://anongit.kde.org/libkexiv2.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "exiv2"
  depends_on "qt"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5KExiv2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
