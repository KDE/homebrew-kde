class Kf5Attica < Formula
  desc "Qt5 library that implements the Open Collaboration Services API"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.70/attica-5.70.0.tar.xz"
  sha256 "bd8980af05ad475ff9573bcfbf9751e7f5117fe35eb55856a3d84fefa20e5cda"
  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
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

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Attica REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
