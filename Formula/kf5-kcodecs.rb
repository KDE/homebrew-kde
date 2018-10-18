class Kf5Kcodecs < Formula
  desc "Collection of methods to manipulate strings"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.51/kcodecs-5.51.0.tar.xz"
  sha256 "55bc4f42e421d9e7ed829d66ff669e15df434941589b0a1b6da34c10d8c71c96"

  head "git://anongit.kde.org/kcodecs.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gperf" => :build
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
