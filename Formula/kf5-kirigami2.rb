class Kf5Kirigami2 < Formula
  desc "QtQuick based components set"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.70/kirigami2-5.70.0.tar.xz"
  sha256 "3cb81f127d5767848aad38fa1722dea7d9c77f70d31ac9088787266b5cf4732a"
  head "git://anongit.kde.org/kirigami.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "KDE-mac/kde/kf5-kpackage" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Kirigami2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
