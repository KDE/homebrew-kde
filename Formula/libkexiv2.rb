class Libkexiv2 < Formula
  desc "Library to manipulate pictures metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/applications/18.12.3/src/libkexiv2-18.12.3.tar.xz"
  sha256 "1d14ff63af42ab7e19e2039648a95ea5dc946afbe3e3df52c17ce1618a02ebdc"

  revision 2
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
