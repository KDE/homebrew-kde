class Kf5Kcodecs < Formula
  url "https://download.kde.org/stable/frameworks/5.40/kcodecs-5.40.0.tar.xz"
  sha256 "a48709850a388543197eb250021672869e1022c087351fc606177e034069097f"
  desc "Provide a collection of methods to manipulate strings using various encodings"
  homepage "https://www.kde.org"

  head "git://anongit.kde.org/kcodecs.git"

  depends_on "cmake" => :build
  depends_on "gperf" => :build
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
