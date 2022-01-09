require_relative "../lib/cmake"

class Kf5Kparts < Formula
  desc "Document centric plugin system"
  homepage "https://api.kde.org/frameworks/kparts/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.90/kparts-5.90.0.tar.xz"
  sha256 "426543fb89b3dbe0c6f374544874ad81fe9c71e85e74ec5b6a4bfd3751eb13f5"
  head "https://invent.kde.org/frameworks/kparts.git", branch: "master"

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
