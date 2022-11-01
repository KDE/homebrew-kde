require_relative "../lib/cmake"

class Kf5Khtml < Formula
  desc "KHTML APIs"
  homepage "https://api.kde.org/frameworks/khtml/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.99/portingAids/khtml-5.99.0.tar.xz"
  sha256 "f92f37167b658fbbfb52ccbc3e6f970fa79f1d3069ef3e2de07a50d3518c936f"
  head "https://invent.kde.org/frameworks/khtml.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gperf" => :build
  depends_on "ninja" => :build

  depends_on "giflib"
  depends_on "jpeg"
  depends_on "kde-mac/kde/kf5-kjs"
  depends_on "kde-mac/kde/kf5-kparts"
  depends_on "kde-mac/kde/phonon"
  depends_on "libpng"
  depends_on "openssl"
  depends_on "zlib"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5KHtml REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
