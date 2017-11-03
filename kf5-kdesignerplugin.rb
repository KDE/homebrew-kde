require "formula"

class Kf5Kdesignerplugin < Formula
  desc "Integration of Frameworks widgets in Qt Designer/Creator"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kdesignerplugin-5.39.0.tar.xz"
  sha256 "ee9c33c583caa1209b112119b2ba6c1f3c14f015b6bafd6e54c97acd8db1f9ac"

  head "git://anongit.kde.org/kdesignerplugin.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
#  depends_on "KDE-mac/kde/kf5-kdewebkit"
  depends_on "KDE-mac/kde/kf5-kplotting"
  depends_on "KDE-mac/kde/kf5-kio"

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
