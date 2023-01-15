require_relative "../lib/cmake"

class Kf5Kmediaplayer < Formula
  desc "Plugin interface for media player features"
  homepage "https://api.kde.org/frameworks/kmediaplayer/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.102/portingAids/kmediaplayer-5.102.0.tar.xz"
  sha256 "da6c644f0c176bf31d6bd75ca10042d039b8c86c2cf7a851b33689b85227be4e"
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
