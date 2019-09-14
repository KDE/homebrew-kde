class Kf5Krunner < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.62/krunner-5.62.0.tar.xz"
  sha256 "21b9564d07395f0e1c5c09557ffc64eb1929dd8925914fdb581f5daa537b01fc"

  head "git://anongit.kde.org/krunner.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-plasma-framework"
  depends_on "KDE-mac/kde/kf5-threadweaver"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Runner REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
