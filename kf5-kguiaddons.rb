class Kf5Kguiaddons < Formula
  desc "Addons to QtGui"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.40/kguiaddons-5.40.0.tar.xz"
  sha256 "e1325bdbbed07ca73a6ee61129af31dd72c29aa7ab5a49bcfd015ea72eb1140a"

  head "git://anongit.kde.org/kguiaddons.git"

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
