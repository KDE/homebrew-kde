class Kf5Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.68/kxmlgui-5.68.0.tar.xz"
  sha256 "6310e9a725a982d3b70672367c5858727437fe08c8e409458e48b6015c7bf10e"

  head "git://anongit.kde.org/kxmlgui.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-attica"
  depends_on "KDE-mac/kde/kf5-kglobalaccel"
  depends_on "KDE-mac/kde/kf5-ktextwidgets"
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
    (testpath/"CMakeLists.txt").write("find_package(KF5XmlGui REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
