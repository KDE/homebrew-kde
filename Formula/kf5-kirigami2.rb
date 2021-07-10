require_relative "../lib/cmake"

class Kf5Kirigami2 < Formula
  desc "QtQuick based components set"
  homepage "https://api.kde.org/frameworks/kirigami/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/kirigami2-5.84.0.tar.xz"
  sha256 "598c9e245d2726ada15c50d51f38827116f25d7e966af0cdfbb3bca396e01716"
  head "https://invent.kde.org/frameworks/kirigami.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "kde-mac/kde/kf5-kpackage" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Kirigami2 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
