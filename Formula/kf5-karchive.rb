class Kf5Karchive < Formula
  desc "Qt 5 addon providing access to numerous types of archives"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/karchive-5.57.0.tar.xz"
  sha256 "e0e64e7e88c8df96f894de20aff4d12925e0d362c5134df83473ea48c0432783"

  head "git://anongit.kde.org/karchive.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "bzip2"
  depends_on "qt"
  depends_on "zlib"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
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
