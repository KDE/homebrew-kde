require_relative "../lib/cmake"

class Kmime < Formula
  desc "Library for handling mail messages and newsgroup articles"
  homepage "https://community.kde.org/KDE_PIM"
  url "https://download.kde.org/stable/release-service/20.12.2/src/kmime-20.12.2.tar.xz"
  sha256 "f18520bd2c4106edf996ea01ab6060071f4c5359ca83a61840515ec19486eeca"
  head "https://invent.kde.org/pim/kmime.git"

  depends_on "cmake" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "ki18n"
  depends_on "kde-mac/kde/kf5-kcodecs"

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
