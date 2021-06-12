require_relative "../lib/cmake"

class Kf5Frameworkintegration < Formula
  desc "Integration of Qt application with KDE workspaces"
  homepage "https://api.kde.org/frameworks/frameworkintegration/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.83/frameworkintegration-5.83.0.tar.xz"
  sha256 "d27a71bf2ef6d68c9ba5aa39dc9cd23b6dbb2ac9c88a12d4f08077e6b3f6b3ab"
  head "https://invent.kde.org/frameworks/frameworkintegration.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/kf5-kpackage"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5FrameworkIntegration REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
