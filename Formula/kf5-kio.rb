require_relative "../lib/cmake"

class Kf5Kio < Formula
  desc "Resource and network access abstraction"
  homepage "https://api.kde.org/frameworks/kio/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/kio-5.85.0.tar.xz"
  sha256 "e4d58a7d2ae6530c4b676fe7f7e4583a86436c68861eb971bf91af9efead19f6"
  head "https://invent.kde.org/frameworks/kio.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

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
