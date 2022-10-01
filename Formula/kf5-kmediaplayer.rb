require_relative "../lib/cmake"

class Kf5Kmediaplayer < Formula
  desc "Plugin interface for media player features"
  homepage "https://api.kde.org/frameworks/kmediaplayer/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.98/portingAids/kmediaplayer-5.98.0.tar.xz"
  sha256 "3d81b6d754564c188bf6a371a3721c092d7eebd395112a978cfda6f77a4a9b71"
  head "https://invent.kde.org/frameworks/kmediaplayer.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kparts"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5MediaPlayer REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
