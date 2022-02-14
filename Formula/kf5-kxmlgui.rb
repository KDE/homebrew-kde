require_relative "../lib/cmake"

class Kf5Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "https://api.kde.org/frameworks/kxmlgui/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/kxmlgui-5.92.0.tar.xz"
  sha256 "e08b4c0d3cc39f788d918bd2ba331966a8af5208233c38a27f029f93a597b743"
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
