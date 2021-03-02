require_relative "../lib/cmake"

class Kf5Sonnet < Formula
  desc "Spelling framework for Qt5"
  homepage "https://api.kde.org/frameworks/sonnet/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/sonnet-5.79.0.tar.xz"
  sha256 "d86f3aa5808784af3019c38126471fdf3add7b3420ce6a8f79a04c86d0ca6125"
  head "https://invent.kde.org/frameworks/sonnet.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "hunspell"
  depends_on "libvoikko"
  depends_on "qt@5"

  depends_on "aspell" => :optional
  depends_on "hspell" => :optional

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Sonnet REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
