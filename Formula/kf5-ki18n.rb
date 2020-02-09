class Kf5Ki18n < Formula
  desc "Advanced internationalization framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.67/ki18n-5.67.0.tar.xz"
  sha256 "85114fb458e66ca7ce02e06fb1b6541989c3516d68873d2ca3fc2438d7258dcd"

  head "git://anongit.kde.org/ki18n.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"
    # cmake thinks libintl is part of libc
    args << "-DCMAKE_SHARED_LINKER_FLAGS=-lintl"
    args << "-DCMAKE_EXE_LINKER_FLAGS=-lintl"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5I18n REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
