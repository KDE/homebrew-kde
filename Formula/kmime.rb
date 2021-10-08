require_relative "../lib/cmake"

class Kmime < Formula
  desc "Library for handling mail messages and newsgroup articles"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/21.08.2/src/kmime-21.08.2.tar.xz"
  sha256 "e47d6ae33a81d7747a9f6ec823f777e379969c6fec03a4e2911b3f734adde0b5"
  head "https://invent.kde.org/pim/kmime.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

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
