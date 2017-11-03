require "formula"

class Kf5Kunitconversion < Formula
  desc "Support for unit conversion"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kunitconversion-5.39.0.tar.xz"
  sha256 "fb53e8d3c8997fbda4cf2b2a2e6ce71eecd44683903e039d35256ec3ac582113"

  head "git://anongit.kde.org/kunitconversion.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-ki18n"

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
