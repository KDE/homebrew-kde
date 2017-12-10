class Kf5Threadweaver < Formula
  desc "High-level multithreading framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.41/threadweaver-5.41.0.tar.xz"
  sha256 "3504d7f97a8f1b3d7180e1cfbf25a270d60875279e53b2e9e523e8d6e0d4d422"
  revision 1

  head "git://anongit.kde.org/threadweaver.git"

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
