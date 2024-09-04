require_relative "../lib/cmake"

class Kf6Kirigami < Formula
  desc "QtQuick based components set"
  homepage "https://api.kde.org/frameworks/kirigami/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kirigami-6.5.0.tar.xz"
  sha256 "43a73b161e1c85da3eadc63e7cc6c1b3c686aa56951b0d0e2df4a2cc1334759c"
  head "https://invent.kde.org/frameworks/kirigami.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "kde-mac/kde/kf6-kpackage" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"

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
    (testpath/"CMakeLists.txt").write("find_package(KF6Kirigami REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
