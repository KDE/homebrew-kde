require_relative "../lib/cmake"

class Kimap < Formula
  desc "Job-based API for interacting with IMAP servers"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/24.08.3/src/kimap-24.08.3.tar.xz"
  sha256 "f2919b4d097e133ffd74a926f6f23b1cc8a80f36890ebe270dfb640d988d387f"
  head "https://invent.kde.org/pim/kimap.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kio"
  depends_on "kde-mac/kde/kmime"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF6IMAP REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
