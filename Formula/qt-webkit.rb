require_relative "../lib/cmake"

class QtWebkit < Formula
  desc "Port of WebKit on top of Qt"
  homepage "https://github.com/qtwebkit/qtwebkit"
  revision 6
  head "https://github.com/qtwebkit/qtwebkit.git", branch: "qtwebkit-dev-wip"

  depends_on "cmake" => [:build, :test]
  depends_on "fontconfig" => :build
  depends_on "freetype" => :build
  depends_on "gperf" => :build
  depends_on "ninja" => :build
  depends_on "python@3.10" => :build
  depends_on "sqlite" => :build

  depends_on "gst-plugins-base"
  depends_on "libxslt"
  depends_on "qt@5"
  depends_on "webp"
  depends_on "woff2"
  depends_on "zlib"
  depends_on "gst-plugins-good" => :recommended

  patch do # Apple Silicon fixes, https://github.com/qtwebkit/qtwebkit/pull/1047
    url "https://github.com/qtwebkit/qtwebkit/commit/219aaeee642bce47773df3e797fe8083207b29e2.patch?full_index=1"
    sha256 "42278c3360d12531487b831e55cfe70b5120c5713f655f3cc6d1c027ca63ec79"
  end

  def install
    # Fuck off rpath
    inreplace "Source/cmake/OptionsQt.cmake",
              "set(CMAKE_MACOSX_RPATH\ ON)",
              ""

    args = %w[
      -DPORT=Qt
      -DENABLE_TOOLS=OFF
      -DCMAKE_MACOSX_RPATH=OFF
      -DEGPF_SET_RPATH=OFF
      -DCMAKE_SKIP_RPATH=ON
      -DCMAKE_SKIP_INSTALL_RPATH=ON
    ]

    system "cmake", *args, *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Qt5 CONFIG COMPONENTS WebKit WebKitWidgets REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
