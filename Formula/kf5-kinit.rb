require_relative "../lib/cmake"

class Kf5Kinit < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://api.kde.org/frameworks/kinit/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.99/kinit-5.99.0.tar.xz"
  sha256 "2302add7e43a9a32aa9a3d5a73e52757e0b321efea6b15a565bf9f683dd60177"
  head "https://invent.kde.org/frameworks/kinit.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Init REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
