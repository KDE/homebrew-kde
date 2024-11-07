require_relative "../lib/cmake"

class KdevPython < Formula
  desc "KDevelop Python language support"
  homepage "https://kde.org/applications/development/org.kde.kdev-python"
  url "https://download.kde.org/stable/release-service/24.08.3/src/kdev-python-24.08.3.tar.xz"
  sha256 "05644c30030bfd51cb541f803f05a42014cb5edf9ff5ebc23858211ace0ddcc2"
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
