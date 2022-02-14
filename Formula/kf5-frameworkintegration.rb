require_relative "../lib/cmake"

class Kf5Frameworkintegration < Formula
  desc "Integration of Qt application with KDE workspaces"
  homepage "https://api.kde.org/frameworks/frameworkintegration/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/frameworkintegration-5.92.0.tar.xz"
  sha256 "bd8ef6f6656c9756a56fbfa1dc91273426ef3ea5fae3e7a4c7dbeddfbbe3ec5d"
  head "https://invent.kde.org/frameworks/frameworkintegration.git", branch: "master"

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
