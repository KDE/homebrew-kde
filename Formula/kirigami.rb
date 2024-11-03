require_relative "../lib/cmake"

class Kirigami < Formula
  desc "QtQuick based components set"
  homepage "https://api.kde.org/frameworks/kirigami/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kirigami-6.7.0.tar.xz"
  sha256 "4d645a0374d33b9465e79e3e17170882e2cbda1526f45bc5b6b176dadda77d76"
  head "https://invent.kde.org/frameworks/kirigami.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "kde-mac/kde/kpackage" => :build
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
