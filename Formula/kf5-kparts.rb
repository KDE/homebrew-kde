require_relative "../lib/cmake"

class Kf5Kparts < Formula
  desc "Document centric plugin system"
  homepage "https://api.kde.org/frameworks/kparts/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.83/kparts-5.83.0.tar.xz"
  sha256 "be087bbfba0735dacf3140f3a23bb08bc1c06d4665c1ed36175a734f5e321aae"
  head "https://invent.kde.org/frameworks/kparts.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Parts REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
