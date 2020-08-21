class Kf5Knotifyconfig < Formula
  desc "Configuration system for KNotify"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.74/knotifyconfig-5.74.0.tar.xz"
  sha256 "8586b39c621068ef31e74884e20cc061577ae8bec50e6e75c88e9bcab46d8e55"
  head "https://invent.kde.org/frameworks/knotifyconfig.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5NotifiConfig REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
