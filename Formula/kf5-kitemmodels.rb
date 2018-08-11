class Kf5Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.49/kitemmodels-5.49.0.tar.xz"
  sha256 "4f368c88ad9254662c9ef0765394e659ac54c9003cf65c0bd1129012c05030bb"

  head "git://anongit.kde.org/kitemmodels.git"

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
