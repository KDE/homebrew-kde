require_relative "../lib/cmake"

class Kf5Kservice < Formula
  desc "Advanced plugin and service introspection"
  homepage "https://api.kde.org/frameworks/kservice/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.83/kservice-5.83.0.tar.xz"
  sha256 "ccd790a18a80aedaa8358ea5d972c7990b9eeea57b64eb3028a7af3c1d5729a2"
  head "https://invent.kde.org/frameworks/kservice.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "bison" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "flex" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcrash"
  depends_on "kde-mac/kde/kf5-kdbusaddons"
  depends_on "ki18n"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Service REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
