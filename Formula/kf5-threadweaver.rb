class Kf5Threadweaver < Formula
  desc "High-level multithreading framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.62/threadweaver-5.62.0.tar.xz"
  sha256 "aa1704c20c6d38fde4f9988e13cb97356e1c69c7a9d0401870b1515a2814294a"

  head "git://anongit.kde.org/threadweaver.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
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

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5ThreadWeaver REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
