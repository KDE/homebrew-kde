require_relative "../lib/cmake"

class Kf5Kmediaplayer < Formula
  desc "Plugin interface for media player features"
  homepage "https://api.kde.org/frameworks/kmediaplayer/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.101/portingAids/kmediaplayer-5.101.0.tar.xz"
  sha256 "084e0215dbe9c3a93b90de680f7a7302c3b0756557d130f977b221e1a5a04123"
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
