require_relative "../lib/cmake"

class KdevPython < Formula
  desc "KDevelop Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/release-service/22.08.2/src/kdev-python-22.08.2.tar.xz"
  sha256 "b775f42b657d01af97be71dbb73ab887cfcbada906eac0129e8199cfa5fcdb0a"
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
