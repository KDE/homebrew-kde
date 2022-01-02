require_relative "../lib/cmake"

class Kf5Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "https://api.kde.org/frameworks/kxmlgui/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.89/kxmlgui-5.89.0.tar.xz"
  sha256 "a6c8938fa2f75c4b9b8c5badd1192a373e2c0b971db17ae5f85ce7d420784e56"
  revision 1
  head "https://invent.kde.org/frameworks/kxmlgui.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  # https://bugs.kde.org/show_bug.cgi?id=446492
  # depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-attica"
  depends_on "kde-mac/kde/kf5-kglobalaccel"
  depends_on "kde-mac/kde/kf5-ktextwidgets"
  depends_on "qt@5"

  def install
    args = kde_cmake_args
    args << "-D BUILD_QCH=OFF" # https://bugs.kde.org/show_bug.cgi?id=446492

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    args = std_cmake_args
    args << "-Wno-dev"

    qt_modules = %w[
      DBus
      Network
      PrintSupport
      Svg
      Widgets
      Xml
    ]

    qt_modules.each do |qt_module|
      args << "-DQt5#{qt_module}_DIR=#{Formula["qt@5"].opt_prefix}/lib/cmake/Qt5#{qt_module}"
    end

    (testpath/"CMakeLists.txt").write("find_package(KF5XmlGui REQUIRED)")
    system "cmake", ".", *args
  end
end
