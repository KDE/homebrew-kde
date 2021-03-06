require_relative "../lib/cmake"

class Kf5Kdesu < Formula
  desc "Integration with su for elevated privileges"
  homepage "https://api.kde.org/frameworks/kdesu/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/kdesu-5.84.0.tar.xz"
  sha256 "2d752997389a57ee7f088c205ce225c5449fe574e061fab1672c33832496742c"
  head "https://invent.kde.org/frameworks/kdesu.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kpty"
  depends_on "kde-mac/kde/kf5-kservice"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Su REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
