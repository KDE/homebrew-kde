require_relative "../lib/cmake"

class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/release-service/21.12.0/src/analitza-21.12.0.tar.xz"
  sha256 "75803adb8573232ef70623557b380cce2145c9eca36f24e6d8032b20f226285b"
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
