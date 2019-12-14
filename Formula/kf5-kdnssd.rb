class Kf5Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.65/kdnssd-5.65.0.tar.xz"
  sha256 "e7f684580f3f6060a73da33439b463ed0f47f72e7129c142b09b4b642331969f"

  head "git://anongit.kde.org/kdnssd.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5DNSSD REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
