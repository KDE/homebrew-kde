class Kf5Kdnssd < Formula
  desc "Abstraction to system DNSSD features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.76/kdnssd-5.76.0.tar.xz"
  sha256 "9cc2979e56915b5c4d8f8e66053a41406bff46aefd65af1ab07d2b87d8f4a753"
  head "https://invent.kde.org/frameworks/kdnssd.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5DNSSD REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
