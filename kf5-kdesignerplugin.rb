class Kf5Kdesignerplugin < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kdesignerplugin-5.40.0.tar.xz"
  sha256 "0d57e158e8247a06b148ff9f65c013257b0f374301dd0f05c5a0c70040239403"
  desc "Integration of Frameworks widgets in Qt Designer/Creator"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kdesignerplugin.git"

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build

  depends_on "KDE-mac/kde/kf5-kdewebkit" => :optional

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
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
