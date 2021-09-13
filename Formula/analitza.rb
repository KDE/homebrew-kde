require_relative "../lib/cmake"

class Analitza < Formula
  desc "Library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/release-service/21.08.1/src/analitza-21.08.1.tar.xz"
  sha256 "c4ae76f8521a61368971611df979472a0bac713abf645389c0aad4dd84644f29"
  head "https://invent.kde.org/education/analitza.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "eigen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  def install
    args = kde_cmake_args

    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt@5"].opt_prefix + "/lib/cmake"

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
