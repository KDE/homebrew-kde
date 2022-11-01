require_relative "../lib/cmake"

class Kmime < Formula
  desc "Library for handling mail messages and newsgroup articles"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/22.08.2/src/kmime-22.08.2.tar.xz"
  sha256 "78dcb4f196dd9b62eddadb085c035fffc7b7b5adcd254088db2b45cb2b9eb59a"
  head "https://invent.kde.org/pim/kmime.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcodecs"
  depends_on "ki18n"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Mime REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
