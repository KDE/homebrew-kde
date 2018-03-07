class Kf5Attica < Formula
  desc "Qt5 library that implements the Open Collaboration Services API"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.42/attica-5.42.0.tar.xz"
  sha256 "adfba910d6d3bbd814b8b8e7322e8181696f180f6088b53cb726e6a5cbd49245"
  revision 1

  head "git://anongit.kde.org/attica.git"

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
