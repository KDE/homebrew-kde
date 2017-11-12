require "formula"

class Kf5Kwidgetsaddons < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kwidgetsaddons-5.40.0.tar.xz"
  sha256 "68420f8315442058d9159ffcb2f296a331ae72ef5126c76b2e8cd715032e069a"
  desc "Addons to QtWidgets"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kwidgetsaddons.git"

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
