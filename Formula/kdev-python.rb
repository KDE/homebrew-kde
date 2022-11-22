require_relative "../lib/cmake"

class KdevPython < Formula
  desc "KDevelop Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/release-service/22.08.3/src/kdev-python-22.08.3.tar.xz"
  sha256 "26952f6a73756dbe0acfe80aaea8e92c22afcd4174a23b29934019c94a608070"
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
