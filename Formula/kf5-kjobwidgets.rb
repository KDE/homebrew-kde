class Kf5Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.58/kjobwidgets-5.58.0.tar.xz"
  sha256 "d43ea4eede2d88edd1753f4d1b6808bf04bf1e67ab58f00ef70b6a20b9607133"
  head "git://anongit.kde.org/kjobwidgets.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "qt"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5JobWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
