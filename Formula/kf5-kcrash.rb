class Kf5Kcrash < Formula
  desc "Support for application crash analysis and bug report from apps"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.49/kcrash-5.49.0.tar.xz"
  sha256 "6315a1607aba1945d3d91092b9440f222f1bb25a8bf01cb0bd507540734eb976"

  head "git://anongit.kde.org/kcrash.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"

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
