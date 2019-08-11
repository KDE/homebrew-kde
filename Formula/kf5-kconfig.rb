class Kf5Kconfig < Formula
  desc "Configuration system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.61/kconfig-5.61.0.tar.xz"
  sha256 "94c0e292a5d57e014aa745be6b59a989118ead1252d56c768f2719b5c6471372"

  head "git://anongit.kde.org/kconfig.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Config REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
