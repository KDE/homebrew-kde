require_relative "../lib/cmake"

class Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "https://api.kde.org/frameworks/kxmlgui/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kxmlgui-6.7.0.tar.xz"
  sha256 "a451c16d70a591de13973079115f35905e3c42302f5c8c8ae3ec75d76a06fca1"
  head "https://invent.kde.org/frameworks/kxmlgui.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/attica"
  depends_on "kde-mac/kde/kglobalaccel"
  depends_on "kde-mac/kde/ktextwidgets"
  depends_on "qt@6"

  def install
    # https://bugs.kde.org/show_bug.cgi?id=446492
    system "cmake", "-D BUILD_QCH=OFF", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    args = ["-Wno-dev"]

    qt_modules = %w[
      DBus
      Network
      PrintSupport
      Svg
      Widgets
      Xml
    ]

    qt_modules.each do |qt_module|
      args << "-DQt5#{qt_module}_DIR=#{Formula["qt@6"].opt_prefix}/lib/cmake/Qt6#{qt_module}"
    end

    (testpath/"CMakeLists.txt").write("find_package(KF6XmlGui REQUIRED)")
    system "cmake", ".", *args, *kde_cmake_args
  end
end
