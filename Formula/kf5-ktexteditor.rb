require_relative "../lib/cmake"

class Kf5Ktexteditor < Formula
  desc "Advanced embeddable text editor"
  homepage "https://api.kde.org/frameworks/ktexteditor/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.95/ktexteditor-5.95.0.tar.xz"
  sha256 "d5e5b63aea8fc8edab681da3033cd40da10daa89262f48ce92c6ab67d59d3e7b"
  head "https://invent.kde.org/frameworks/ktexteditor.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "editorconfig"
  depends_on "kde-mac/kde/kf5-kparts"
  depends_on "kde-mac/kde/kf5-syntax-highlighting"
  depends_on "libgit2"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5TesxtEditor REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
