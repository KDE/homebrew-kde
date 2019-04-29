class KdevelopPgQt < Formula
  desc "LL(1) parser generator based on Qt"
  homepage "https://kdevelop.org"
  url "https://download.kde.org/stable/kdevelop-pg-qt/2.1.0/src/kdevelop-pg-qt-2.1.0.tar.xz"
  sha256 "20d84d25bd40610bd6c0964e4fe0642e56c41b76a65575122dc5196649621e5d"
  revision 2
  head "git://anongit.kde.org/kdevelop-pg-qt.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KDevelop-PG-Qt REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
