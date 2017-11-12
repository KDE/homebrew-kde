class Kf5Kmediaplayer < Formula
  url "https://download.kde.org/stable/frameworks/5.40/portingAids/kmediaplayer-5.40.0.tar.xz"
  sha256 "f44e170996411fcde7a63fd847631a4b8ed45d7098a56a26b866b3fd0d9bfe8e"
  desc "Plugin interface for media player features"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-kparts"

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
