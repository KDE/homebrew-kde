class Kf5Karchive < Formula
  desc "Qt 5 addon providing access to numerous types of archives"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.71/karchive-5.71.0.tar.xz"
  sha256 "cc81e856365dec2bcf3ec78aa01d42347ca390a2311ea12050f309dfbdb09624"
  head "https://invent.kde.org/frameworks/karchive.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "bzip2"
  depends_on "qt"
  depends_on "zlib"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Archive REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
