class Kf5Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/kwindowsystem-5.57.0.tar.xz"
  sha256 "0c8a009dde7ca1722810777b99aa4e1a3471687460c25e0f41645c9e11daf274"

  head "git://anongit.kde.org/kwindowsystem.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

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
