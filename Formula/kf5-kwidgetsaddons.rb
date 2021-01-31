require_relative "../lib/cmake"

class Kf5Kwidgetsaddons < Formula
  desc "Addons to QtWidgets"
  homepage "https://api.kde.org/frameworks/kwidgetsaddons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/kwidgetsaddons-5.79.0.tar.xz"
  sha256 "ac47d79f9a9f839f3b49b4fc89c07e56787ed4b662898443c69b9d3454e7ee4a"
  head "https://invent.kde.org/frameworks/kwidgetsaddons.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5WidgetsAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
