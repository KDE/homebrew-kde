class Kf5Knotifyconfig < Formula
  desc "Configuration system for KNotify"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.68/knotifyconfig-5.68.0.tar.xz"
  sha256 "36c7c93964f2b9b584d73de1757f75d6ee8bb29ebe860e8fd6905354d2f10145"

  head "git://anongit.kde.org/knotifyconfig.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
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
