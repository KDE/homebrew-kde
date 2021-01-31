require_relative "../lib/cmake"

class Kf5Ktexteditor < Formula
  desc "Advanced embeddable text editor"
  homepage "https://api.kde.org/frameworks/ktexteditor/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/ktexteditor-5.79.0.tar.xz"
  sha256 "83b94589d3a23f0b268eb5cfa9544541ac0015ecfab5cf3fd5e95e4499d155b3"
  head "https://invent.kde.org/frameworks/ktexteditor.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
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
