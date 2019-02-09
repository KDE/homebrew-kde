class Kf5Kguiaddons < Formula
  desc "Addons to QtGui"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.55/kguiaddons-5.55.0.tar.xz"
  sha256 "039a0f98b5491668ea4e2e45ca57c68bd5fea956f46ba50778283a8137e412a4"

  head "git://anongit.kde.org/kguiaddons.git"

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
