require_relative "../lib/cmake"

class Libktorrent < Formula
  desc "BitTorrent protocol implementation"
  homepage "https://www.kde.org/applications/internet/ktorrent/"
  url "https://download.kde.org/stable/ktorrent/5.2.0/libktorrent-2.2.0.tar.xz"
  sha256 "77c1ddfb0a56c40227e0624c078836a8c22bf5a2fb4a3c0cbd53ee6b174c126e"
  head "https://invent.kde.org/network/libktorrent.git", branch: "master"

  livecheck do
    skip "Newer versions doesn't compile due to bug: https://bugs.kde.org/show_bug.cgi?id=430896"
  end

  depends_on "boost" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "qca"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Torrent REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
