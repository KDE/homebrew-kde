require_relative "../lib/cmake"

class Kf5Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "https://api.kde.org/frameworks/kxmlgui/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.98/kxmlgui-5.98.0.tar.xz"
  sha256 "857440cf53774786433967b47e27f509f322c9aca5bbccb1ea0ec0f9fea0c522"
  head "https://invent.kde.org/frameworks/kxmlgui.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-attica"
  depends_on "kde-mac/kde/kf5-kglobalaccel"
  depends_on "kde-mac/kde/kf5-ktextwidgets"
  depends_on "qt@5"

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
      args << "-DQt5#{qt_module}_DIR=#{Formula["qt@5"].opt_prefix}/lib/cmake/Qt5#{qt_module}"
    end

    (testpath/"CMakeLists.txt").write("find_package(KF5XmlGui REQUIRED)")
    system "cmake", ".", *args, *kde_cmake_args
  end
end
