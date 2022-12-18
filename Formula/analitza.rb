require_relative "../lib/cmake"

class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/release-service/22.12.0/src/analitza-22.12.0.tar.xz"
  sha256 "46dcaef7fe08c2a942992057d6c2c6c860a03df6eed6662a780b9f55a18cdfc1"
  head "https://invent.kde.org/education/analitza.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "eigen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  def install
    system "cmake", "-DCMAKE_PREFIX_PATH=#{Formula["qt@5"].opt_prefix}/lib/cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Analitza5 REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
