class Kf5Kitemmodels < Formula
  desc "Models for Qt Model/View system"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.74/kitemmodels-5.74.0.tar.xz"
  sha256 "89c91051445137959e3dd7276d428adaff09b1ca9980f37d4a66d0c34c7b36c1"
  head "https://invent.kde.org/frameworks/kitemmodels.git"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5ItemModels REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
