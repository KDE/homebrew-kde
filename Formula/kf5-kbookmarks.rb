class Kf5Kbookmarks < Formula
  desc "Support for bookmarks and the XBEL format"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.66/kbookmarks-5.66.0.tar.xz"
  sha256 "b225463ec0fe2424a1f5e70c83b02e3ece6a3ca80832cd2621732d18d7160a43"

  head "git://anongit.kde.org/kbookmarks.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kxmlgui"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Bookmarks REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
