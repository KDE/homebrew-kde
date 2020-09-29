class Kf5Knewstuff < Formula
  desc "Support for downloading application assets from the network"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.74/knewstuff-5.74.0.tar.xz"
  sha256 "638ba6cee3091a94a0ef60977b6e22c7b58267ea6fd1bc17d3e7ac47bd9a3d27"
  revision 2
  head "https://invent.kde.org/frameworks/knewstuff.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kpackage"

  depends_on "KDE-mac/kde/kf5-kirigami2" => :optional

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(ECM REQUIRED)
      set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})
      find_package(KF5NewStuff REQUIRED)
      find_package(KF5NewStuffCore REQUIRED)
      find_package(KF5NewStuffQuick REQUIRED)
    EOS

    args = std_cmake_args
    args << "-Wno-dev"
    args << "-DQt5Widgets_DIR=#{Formula["qt"].opt_prefix/"lib/cmake/Qt5Widgets"}"
    args << "-DQt5Xml_DIR=#{Formula["qt"].opt_prefix/"lib/cmake/Qt5Xml"}"
    args << "-DQt5Network_DIR=#{Formula["qt"].opt_prefix/"lib/cmake/Qt5Network"}"

    system "cmake", ".", *args
  end
end
