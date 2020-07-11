class Kf5Kfilemetadata < Formula
  desc "Library for extracting file metadata"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.72/kfilemetadata-5.72.0.tar.xz"
  sha256 "6f93d0b5dedb3beffbb7626130707a3b11522c58b3081e3b539dbeb9fbd3d1c3"
  head "https://invent.kde.org/frameworks/kfilemetadata.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "ebook-tools"
  depends_on "exiv2"
  depends_on "ffmpeg"
  depends_on "kde-karchive"
  depends_on "kde-ki18n"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "poppler"
  depends_on "taglib"

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

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5FileMetaData REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
