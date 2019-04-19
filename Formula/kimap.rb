class Kimap < Formula
  desc "Job-based API for interacting with IMAP servers"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/applications/19.04.0/src/kimap-19.04.0.tar.xz"
  sha256 "cda62c81c47011ad2adbf78222eab4528a62116487531ce1aa98f6100706d2fd"

  head "git://anongit.kde.org/kimap.git"
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kmime"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
