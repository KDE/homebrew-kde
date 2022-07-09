require_relative "../lib/cmake"

class Kf5PlasmaFramework < Formula
  desc "Plasma library and runtime components based upon KF5 & Qt5"
  homepage "https://api.kde.org/frameworks/plasma-framework/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.96/plasma-framework-5.96.0.tar.xz"
  sha256 "0236ea39448299d9c861cf8da2582baeec7ccfd4660406c47abec70bcedebe92"
  head "https://invent.kde.org/frameworks/plasma-framework.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kactivities"
  depends_on "kde-mac/kde/kf5-kdeclarative"
  depends_on "kde-mac/kde/kf5-kirigami2"

  patch do
    url "https://invent.kde.org/frameworks/plasma-framework/-/commit/dff1b034c1162062aa2292099d3d01fc53dafdf6.diff"
    sha256 "f2e7b421073544c7e9fcc530f21701bae33279bad840573e0351e00ba806901e"
  end

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
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KF5Plasma REQUIRED)
      find_package(KF5PlasmaQuick REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end
