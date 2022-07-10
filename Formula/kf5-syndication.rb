class Kf5Syndication < Formula
  desc "An RSS/Atom parser library"
  homepage "https://api.kde.org/frameworks/syndication/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.96/syndication-5.96.0.tar.xz"
  sha256 "a4b1dbf8c0eed15eab9f520512fee6271b07fac0745c2b1fc6ccae49ed6fc0e0"
  head "https://invent.kde.org/frameworks/syndication.git", branch: "master"

  depends_on "cmake" => [:build,:test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kcodecs"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Syndication REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
