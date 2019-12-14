class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/release-service/19.12.0/src/libkexiv2-19.12.0.tar.xz"
  sha256 "3bd7c155c4b7d01f8b1af7ee0d11c9efed18399a239135a25b570ff8650239b7"

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
