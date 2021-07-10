require_relative "../lib/cmake"

class Kf5Kxmlgui < Formula
  desc "User configurable main windows"
  homepage "https://api.kde.org/frameworks/kxmlgui/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/kxmlgui-5.84.0.tar.xz"
  sha256 "2c3cbd25499dc51e45270c525a528efe16d26a07dc2047fa074708ceb9dcaeb5"
  head "https://invent.kde.org/frameworks/kxmlgui.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-attica"
  depends_on "kde-mac/kde/kf5-kglobalaccel"
  depends_on "kde-mac/kde/kf5-ktextwidgets"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5XmlGui REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
