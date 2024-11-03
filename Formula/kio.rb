require_relative "../lib/cmake"

class Kio < Formula
  desc "Resource and network access abstraction"
  homepage "https://api.kde.org/frameworks/kio/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kio-6.7.0.tar.xz"
  sha256 "df235019a07acd579920f6c655050e02dacf847c706f4b8279e755be46f9d990"
  head "https://invent.kde.org/frameworks/kio.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "desktop-file-utils"
  depends_on "kde-mac/kde/kbookmarks"
  depends_on "kde-mac/kde/kjobwidgets"
  depends_on "kde-mac/kde/kwallet"
  depends_on "kde-mac/kde/solid"
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
