require_relative "../lib/cmake"

class Kf5Kded < Formula
  desc "Extensible deamon for providing system level services"
  homepage "https://api.kde.org/frameworks/kded/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/kded-5.92.0.tar.xz"
  sha256 "8335531b856cb361ab2e5b390b333eb3405bac4e2bc7c0305994704bd0540e6c"
  head "https://invent.kde.org/frameworks/kded.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kinit"

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
    (testpath/"CMakeLists.txt").write("find_package(KDED REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
