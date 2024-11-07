require_relative "../lib/cmake"

class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/release-service/24.08.3/src/analitza-24.08.3.tar.xz"
  sha256 "9f0b7063ea5f5d7c2131d4a6dcccd3275d31a4968ba6eb0920a70ca7fc90d68e"
  head "https://invent.kde.org/education/analitza.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "eigen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  def install
    system "cmake", "-DCMAKE_PREFIX_PATH=#{Formula["qt@6"].opt_prefix}/lib/cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Analitza5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
