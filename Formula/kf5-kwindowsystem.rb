class Kf5Kwindowsystem < Formula
  desc "Access to the windowing system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kwindowsystem-5.56.0.tar.xz"
  sha256 "ecb39fcbe48e24c0a3b9c70b9b08c3c95ade446759b850bf5079df7669f56936"

  head "git://anongit.kde.org/kwindowsystem.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
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
