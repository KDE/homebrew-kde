class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/release-service/20.12.0/src/libkexiv2-20.12.0.tar.xz"
  sha256 "534a28648861f1d10e46a5b95c4c7dc27eb2028bf1e0cddd9814237d9c8d114c"
  head "https://invent.kde.org/graphics/libkexiv2.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
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
