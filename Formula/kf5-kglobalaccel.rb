require_relative "../lib/cmake"

class Kf5Kglobalaccel < Formula
  desc "Add support for global workspace shortcuts"
  homepage "https://api.kde.org/frameworks/kglobalaccel/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.85/kglobalaccel-5.85.0.tar.xz"
  sha256 "e0dcfb844572c23b0504b9cca7b1d0a0f7f47e2f4469968754ca0045c8f0b438"
  head "https://invent.kde.org/frameworks/kglobalaccel.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kcrash"
  depends_on "kde-mac/kde/kf5-kdbusaddons"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5GlobalAccel REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
