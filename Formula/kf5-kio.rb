require_relative "../lib/cmake"

class Kf5Kio < Formula
  desc "Resource and network access abstraction"
  homepage "https://api.kde.org/frameworks/kio/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.93/kio-5.93.0.tar.xz"
  sha256 "d290a4bcfb5ec9eb9047c84a7c420df831131b92ab6c9d28a3aa0eef9f5d4c44"
  head "https://invent.kde.org/frameworks/kio.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "desktop-file-utils"
  depends_on "kde-mac/kde/kf5-kbookmarks"
  depends_on "kde-mac/kde/kf5-kjobwidgets"
  depends_on "kde-mac/kde/kf5-kwallet"
  depends_on "kde-mac/kde/kf5-solid"
  depends_on "libxslt"
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
    (testpath/"CMakeLists.txt").write("find_package(KF5KIO REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
