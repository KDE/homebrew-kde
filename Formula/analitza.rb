require_relative "../lib/cmake"

class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/release-service/22.04.1/src/analitza-22.04.1.tar.xz"
  sha256 "7274f17ad5da2143e88e69933f6e733412379213d1613455c031df8e5dff1d28"
  head "https://invent.kde.org/education/analitza.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "eigen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  def install
    args = kde_cmake_args

    args << ("-DCMAKE_PREFIX_PATH=" + Formula["qt@5"].opt_prefix + "/lib/cmake")

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Analitza5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
