require_relative "../lib/cmake"

class Kmime < Formula
  desc "Library for handling mail messages and newsgroup articles"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/21.12.3/src/kmime-21.12.3.tar.xz"
  sha256 "fc5a1b86a18c0b0ef67759e3813cb49b3286b101f8494ce0497737ee29a1470f"
  head "https://invent.kde.org/pim/kmime.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcodecs"
  depends_on "ki18n"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Mime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
