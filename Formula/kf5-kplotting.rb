class Kf5Kplotting < Formula
  desc "Lightweight plotting framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.77/kplotting-5.77.0.tar.xz"
  sha256 "32226573989c105d84a324174d31a1ed4c7cbf57a75341873cd8fe5692d7a2e8"
  head "https://invent.kde.org/frameworks/kplotting.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Plotting REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
