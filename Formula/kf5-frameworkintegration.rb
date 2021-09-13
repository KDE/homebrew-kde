require_relative "../lib/cmake"

class Kf5Frameworkintegration < Formula
  desc "Integration of Qt application with KDE workspaces"
  homepage "https://api.kde.org/frameworks/frameworkintegration/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.86/frameworkintegration-5.86.0.tar.xz"
  sha256 "d44677cc3dff45584ab0fef72671a16dc0b45382dcb408e56c094f5feb352669"
  head "https://invent.kde.org/frameworks/frameworkintegration.git", branch: "master"

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
