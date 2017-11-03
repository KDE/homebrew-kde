require "formula"

class Kf5Kconfig < Formula
  desc "Configuration system"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kconfig-5.39.0.tar.xz"
  sha256 "3c504d69a38d7fa2e89dbe15b8c02d0803be20f3907c86f18be090031c223104"

  head "git://anongit.kde.org/kconfig.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

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
