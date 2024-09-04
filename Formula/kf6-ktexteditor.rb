require_relative "../lib/cmake"

class Kf6Ktexteditor < Formula
  desc "Advanced embeddable text editor"
  homepage "https://api.kde.org/frameworks/ktexteditor/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/ktexteditor-6.5.0.tar.xz"
  sha256 "9bbb8875a68c6b627f3999c2dab2f91fe15570e2a43c3b2aa9149e5b98dbb8c1"
  head "https://invent.kde.org/frameworks/ktexteditor.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "editorconfig"
  depends_on "kde-mac/kde/kf6-kparts"
  depends_on "kde-mac/kde/kf6-syntax-highlighting"
  depends_on "libgit2"

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
    (testpath/"CMakeLists.txt").write("find_package(KF6TesxtEditor REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
