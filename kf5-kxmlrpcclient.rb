class Kf5Kxmlrpcclient < Formula
  desc "XML-RPC client library for KDE"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.40/kxmlrpcclient-5.40.0.tar.xz"
  sha256 "14d8bd7109d013964ba952402fe439e749bcef97d4588b7a7dd269e1b07deb07"
  revision 1

  head "git://anongit.kde.org/kxmlrpcclient.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
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
