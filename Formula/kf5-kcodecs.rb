class Kf5Kcodecs < Formula
  desc "Collection of methods to manipulate strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.67/kcodecs-5.67.0.tar.xz"
  sha256 "4fb9d2d2142306ff60b0855923be20a2a4d959075379c86c9af7023e20bdbab2"

  head "git://anongit.kde.org/kcodecs.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gperf" => :build
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
    (testpath/"CMakeLists.txt").write("find_package(KF5Codecs REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
