require "formula"

class Kf5Kjobwidgets < Formula
  desc "Widgets for tracking KJob instances"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kjobwidgets-5.39.0.tar.xz"
  sha256 "ccfd26c54e15a854d4d86028e7339dcbe33b0c52412686b89b2dc7794b2946fc"

  head "git://anongit.kde.org/kjobwidgets.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"

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
