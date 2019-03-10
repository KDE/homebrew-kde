class Kf5Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kdnssd-5.56.0.tar.xz"
  sha256 "7e1383580f97248d8bfb6522bd230657bd002d3eb0e74a178bccc8a511e353bf"
  head "git://anongit.kde.org/kdnssd.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
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
