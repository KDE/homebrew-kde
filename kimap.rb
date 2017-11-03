require "formula"

class Kimap < Formula
  desc "Job-based API for interacting with IMAP servers"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/applications/17.08.2/src/kimap-17.08.2.tar.xz"
  sha256 "ab3a7748d913a4162703a044f9d383cb4f2b395da35b52ebced8419180c7974e"

  head "git://anongit.kde.org/kimap.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kdoctools"
  depends_on "KDE-mac/kde/cyrus-sasl"
  depends_on "KDE-mac/kde/kmime"

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
