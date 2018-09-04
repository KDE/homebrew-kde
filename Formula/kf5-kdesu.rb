class Kf5Kdesu < Formula
  desc "Integration with su for elevated privileges"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.49/kdesu-5.49.0.tar.xz"
  sha256 "b398a310d4f84e049f8f41cbe65a2baa9b6a72a7d75eb985ce73611c8a5f9bbf"

  head "git://anongit.kde.org/kdesu.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "KDE-mac/kde/kf5-kservice"
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
