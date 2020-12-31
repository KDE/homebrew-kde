class Kf5Kiconthemes < Formula
  desc "Support for icon themes"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.77/kiconthemes-5.77.0.tar.xz"
  sha256 "735834671bd32f26da075d25f4209faac04fcc6af2f4090f99d055a3a277dc79"
  head "https://invent.kde.org/frameworks/kiconthemes.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-karchive"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kitemviews"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5IconThemes REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
