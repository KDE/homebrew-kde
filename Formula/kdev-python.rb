require_relative "../lib/cmake"

class KdevPython < Formula
  desc "KDevelop Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/release-service/24.08.2/src/kdev-python-24.08.2.tar.xz"
  sha256 "de2f3bcbddf5d86a672c7823e7401cf379265875867104641117620d1a1493ad"
  head "https://invent.kde.org/kdevelop/kdev-python.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "kdevelop"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
end
