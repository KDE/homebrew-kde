class Kf5Kirigami2 < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kirigami2-5.40.0.tar.xz"
  sha256 "2b4b6c6aa5b6fdb57d19345526628f528b6e57fa4a471d4b83e0ceec3a674228"
  desc "A QtQuick based components set"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kirigami2.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
