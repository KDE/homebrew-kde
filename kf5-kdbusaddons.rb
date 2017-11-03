require "formula"

class Kf5Kdbusaddons < Formula
  desc "Addons to QtDBus"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kdbusaddons-5.39.0.tar.xz"
  sha256 "23477be1a3271d599be896477253fbcd9895ca8688ecb6771b290c5b522ae842"

  head "git://anongit.kde.org/kdbusaddons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "shared-mime-info" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "dbus"

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
