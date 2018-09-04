class Kf5Kcodecs < Formula
  desc "Collection of methods to manipulate strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.49/kcodecs-5.49.0.tar.xz"
  sha256 "df0ed5de74ac1c0edd0fee75b4c7bafd7bce864891b69c142c2c4ba7df306a1f"

  head "git://anongit.kde.org/kcodecs.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gperf" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
