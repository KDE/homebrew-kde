require_relative "../lib/cmake"

class Kf5Solid < Formula
  desc "Hardware integration and detection"
  homepage "https://api.kde.org/frameworks/solid/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/solid-5.85.0.tar.xz"
  sha256 "a7e416de2c3d699fbaea1b8395be1a0ee50f0262303d47dc6b491ef0f36b8d3d"
  head "https://invent.kde.org/frameworks/solid.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "bison" => :build
  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "flex" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    args = kde_cmake_args
    # setTime_t function is deprecated since 5.8.
    # args << "-DCMAKE_C_FLAGS_RELEASE=-DNDEBUG -DQT_DISABLE_DEPRECATED_BEFORE=0x050700"
    # args << "-DCMAKE_CXX_FLAGS_RELEASE=-DNDEBUG -DQT_DISABLE_DEPRECATED_BEFORE=0x050700"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Solid REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
