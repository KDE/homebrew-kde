class QtWebkit < Formula
  desc "Classes for a WebKit2 based implementation and a new QML API"
  homepage "https://www1.qt.io/developers/"
  url "https://code.qt.io/qt/qtwebkit.git", :tag => "v5.212.0-alpha3", :shallow => true
  version "5.212.0.alpha3"
  revision 2

  head "https://code.qt.io/qt/qtwebkit.git"

  depends_on "cmake" => :build
  depends_on "fontconfig" => :build
  depends_on "freetype" => :build
  depends_on "gperf" => :build
  depends_on "ninja" => :build
  depends_on "sqlite" => :build

  depends_on "libxslt"
  depends_on "qt"
  depends_on "webp"
  depends_on "zlib"

  def cmake_args
    args = %W[
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DCMAKE_BUILD_TYPE=Release
      -DCMAKE_FIND_FRAMEWORK=LAST
      -DCMAKE_VERBOSE_MAKEFILE=ON
      -Wno-dev
    ]
    args
  end

  def install
    args = cmake_args
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"
    args << "-DPORT=Qt"
    args << "-DENABLE_TOOLS=OFF"
    args << "-DCMAKE_MACOSX_RPATH=OFF"
    args << "-DEGPF_SET_RPATH=OFF"
    args << "-DCMAKE_SKIP_RPATH=ON"
    args << "-DCMAKE_SKIP_INSTALL_RPATH=ON"

    # Fuck off rpath
    inreplace "Source/cmake/OptionsQt.cmake",
              "set(CMAKE_MACOSX_RPATH\ ON)",
              ""

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Qt5 CONFIG COMPONENTS WebKit WebKitWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
