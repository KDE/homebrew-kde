class Kdiagram < Formula
  desc "Powerful libraries for creating business diagrams"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/kdiagram/2.6.0/src/kdiagram-2.6.0.tar.xz"
  sha256 "02788dad7e15c64b74a2d1073c5910469ab4cf46ba905030c1713dce45981882"
  revision 2
  head "git://anongit.kde.org/kdiagram.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
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
