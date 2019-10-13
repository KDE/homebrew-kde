class Kf5Ki18n < Formula
  desc "Advanced internationalization framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.63/ki18n-5.63.0.tar.xz"
  sha256 "491395d2d725e1f25acefeea542d1e12e51673636bbc657d5f1f2fbcdb02b7b9"

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
