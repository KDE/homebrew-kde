class Kf5Kxmlrpcclient < Formula
  desc "XML-RPC client library for KDE"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.72/portingAids/kxmlrpcclient-5.72.0.tar.xz"
  sha256 "22102e31a0ef6c0007f1e87382fd0b4501151e7604f1d6605feb10fd5a5e55a2"
  head "https://invent.kde.org/frameworks/kxmlrpcclient.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kio"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5XmlRpcClient REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
