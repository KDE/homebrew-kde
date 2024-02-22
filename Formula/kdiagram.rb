require_relative "../lib/cmake"

class Kdiagram < Formula
  desc "Powerful libraries for creating business diagrams"
  homepage "https://api.kde.org/kdiagram/index.html"
  url "https://download.kde.org/stable/kdiagram/3.0.1/kdiagram-3.0.1.tar.xz"
  sha256 "4659b0c2cd9db18143f5abd9c806091c3aab6abc1a956bbf82815ab3d3189c6d"
  head "https://invent.kde.org/graphics/kdiagram.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt@5"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      find_package(KChart REQUIRED)
      find_package(KGrantt REQUIRED)
    EOS
    system "cmake", ".", "-Wno-dev"
  end
end
