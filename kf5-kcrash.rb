require "formula"

class Kf5Kcrash < Formula
  url "https://download.kde.org/stable/frameworks/5.39/kcrash-5.39.0.tar.xz"
  sha256 "9a0727734745b3050f864f2de1dbdb91e9ac99a49ede9874613427080a1563bb"
  desc "Support for application crash analysis and bug report from apps"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcrash.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
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
