require "formula"

class Kf5Krunner < Formula
  url "https://download.kde.org/stable/frameworks/5.39/krunner-5.39.0.tar.xz"
  sha256 "d43d3821b64a49fec7f06a3ad410f15412cebbe7f365c64a307a2c5ad14fba3f"
  desc "Process launcher to speed up launching KDE applications"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/krunner.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-threadweaver"

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

