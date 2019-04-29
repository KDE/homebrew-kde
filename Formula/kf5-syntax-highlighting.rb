class Kf5SyntaxHighlighting < Formula
  desc "Syntax highlighting engine for structured text and code"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.57/syntax-highlighting-5.57.0.tar.xz"
  sha256 "e82261e791005a55414fc81a396ca33ee8c061acd66c2c351492d866b3592e9f"

  head "git://anongit.kde.org/syntax-highlighting.git"

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

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5SyntaxHighlighting REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
