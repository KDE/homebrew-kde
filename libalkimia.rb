require "formula"

class Libalkimia < Formula
  desc "Library used by KDE Finance applications"
  homepage "http://kmymoney.org/"
  url "http://download.kde.org/stable/alkimia/5.0.0/src/libalkimia-5.0.0.tar.xz"
  sha256 "eea8a2a0f6788a1b9fd464b370598ed6e55353fb40da53375e6f022e71526cb5"

  head "git://anongit.kde.org/alkimia.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "gmp"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"


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
