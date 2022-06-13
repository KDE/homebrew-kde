require_relative "../lib/cmake"

class Kf5Kpimtextedit < Formula
  desc "A textedit with PIM-specific features"
  homepage "https://api.kde.org/kdepim/kpimtextedit/html/index.html"
  url "https://download.kde.org/stable/release-service/22.04.1/src/kpimtextedit-22.04.1.tar.xz"
  sha256 "f6cedefcc351069e01d0f3f15d4eaefe0ecb2865aaab3e17811af54a39f9bfc7"
  head "https://invent.kde.org/pim/kpimtextedit.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]

  depends_on "qt@5"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-syntax-highlighting"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5PIMTextEdit REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
