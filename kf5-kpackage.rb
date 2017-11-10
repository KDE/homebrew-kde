require "formula"

class Kf5Kpackage < Formula
  url "https://download.kde.org/stable/frameworks/5.39/kpackage-5.39.0.tar.xz"
  sha256 "713eff23f61d9766f02b40cc6cfa73acd31d126a0c6a775903f79c9adebc77c5"
  desc "Framework that lets applications manage user installable packages of non-binary assets"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kpackage.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-ki18n"
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
