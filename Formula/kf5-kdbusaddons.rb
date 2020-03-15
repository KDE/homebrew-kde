class Kf5Kdbusaddons < Formula
  desc "Addons to QtDBus"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.68/kdbusaddons-5.68.0.tar.xz"
  sha256 "839fe42f9ac8df353f87245110fd7b515a8eb29f0840f54481bd89e5175bf1af"

  head "git://anongit.kde.org/kdbusaddons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "dbus"
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
    (testpath/"CMakeLists.txt").write("find_package(KF5DBusAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
