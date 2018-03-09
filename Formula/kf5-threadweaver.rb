class Kf5Threadweaver < Formula
  desc "High-level multithreading framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.44/threadweaver-5.44.0.tar.xz"
  sha256 "645d261701fe39a07524e8bc1b45027283e83c655cb7055d486163f182e3584e"
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
