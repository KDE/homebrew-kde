class Kf5Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.40/kwindowsystem-5.40.0.tar.xz"
  sha256 "fff33531367425be18af75f10a8e40ff52f1383ecf97f37cf9c7c39baa308033"
  revision 1

  head "git://anongit.kde.org/kwindowsystem.git"

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
