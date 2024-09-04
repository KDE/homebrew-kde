require_relative "../lib/cmake"

class Kf6Kio < Formula
  desc "Resource and network access abstraction"
  homepage "https://api.kde.org/frameworks/kio/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kio-6.5.0.tar.xz"
  sha256 "9c8bf83534577a322d4633d241d9770bc8ba8a45624e2f041e1b8dbdbc198a13"
  head "https://invent.kde.org/frameworks/kio.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "desktop-file-utils"
  depends_on "kde-mac/kde/kf6-kbookmarks"
  depends_on "kde-mac/kde/kf6-kjobwidgets"
  depends_on "kde-mac/kde/kf6-kwallet"
  depends_on "kde-mac/kde/kf6-solid"
  depends_on "libxslt"
  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
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
    (testpath/"CMakeLists.txt").write("find_package(KF6KIO REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
