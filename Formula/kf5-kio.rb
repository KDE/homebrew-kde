class Kf5Kio < Formula
  desc "Resource and network access abstraction"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.66/kio-5.66.0.tar.xz"
  sha256 "c5350e20474b48c4fc02347186b7e4db24cb7580ba8c0f1e120b302e6b8db17d"
  head "git://anongit.kde.org/kio.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "desktop-file-utils"
  depends_on "KDE-mac/kde/kf5-kbookmarks"
  depends_on "KDE-mac/kde/kf5-kjobwidgets"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-solid"
  depends_on "libxslt"
  depends_on "qt"

  depends_on "KDE-mac/kde/kio-extras" => :optional

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

  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
      "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
  EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5KIO REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
