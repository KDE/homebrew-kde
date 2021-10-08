require_relative "../lib/cmake"

class KdevPython < Formula
  desc "KDevelop Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/kdevelop/5.6.2/src/kdev-python-5.6.2.tar.xz"
  sha256 "20f9b771b961262ded986a4f32b8d259ad9f7bc48bb29eac0a5d5853be1d917f"
  head "https://invent.kde.org/kdevelop/kdev-python.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "kdevelop"

  def install
    args = kde_cmake_args
    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
end
