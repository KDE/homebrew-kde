class Kf5Karchive < Formula
  desc "Qt 5 addon providing access to numerous types of archives"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.46/karchive-5.46.0.tar.xz"
  sha256 "48e47bf26542e84aeb2e03bba7f50f32d880f2c15b17ad17d19cc54e517df0f6"

  head "git://anongit.kde.org/karchive.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "zlib"
  depends_on "bzip2"

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
