class Kf5Kguiaddons < Formula
  desc "Addons to QtGui"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.74/kguiaddons-5.74.0.tar.xz"
  sha256 "bb7c5b88e1738b22571f2f135202b3c08230911fcb8d089b8676d4d59af4578b"
  head "https://invent.kde.org/frameworks/kguiaddons.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5GuiAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
