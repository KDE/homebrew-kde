require_relative "../lib/cmake"

class Kf5Kjs < Formula
  desc "Support for JS scripting in applications"
  homepage "https://api.kde.org/frameworks/kjs/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.87/portingAids/kjs-5.87.0.tar.xz"
  sha256 "e879d3f1df4facb42abc87c0fa5a8958d4ea63962d2ff19caf56cc319f841cc6"
  head "https://invent.kde.org/frameworks/kjs.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "pcre"
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
    (testpath/"CMakeLists.txt").write("find_package(KF5JS REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
