require_relative "../lib/cmake"

class Kf5Kpeople < Formula
  desc "Provides access to all contacts and the people"
  homepage "https://api.kde.org/frameworks/kpeople/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.102/kpeople-5.102.0.tar.xz"
  sha256 "623743a8521a8eace1d0006f6e5f8300cdd1fdb40b22e7cd5f61cbf1154720f2"
  head "https://invent.kde.org/frameworks/kpeople.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kitemviews"
  depends_on "kde-mac/kde/kf5-kservice"
  depends_on "kde-mac/kde/kf5-kwidgetsaddons"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5People REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
