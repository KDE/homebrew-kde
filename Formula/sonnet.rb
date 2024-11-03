require_relative "../lib/cmake"

class Sonnet < Formula
  desc "Spelling framework for Qt6"
  homepage "https://api.kde.org/frameworks/sonnet/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/sonnet-6.7.0.tar.xz"
  sha256 "2f970d490effd668e64dd93ffef344a80db7e63130bb23df4fa0d6b14150e588"
#  url "https://download.kde.org/stable/frameworks/6.5/sonnet-6.5.0.tar.xz"
#  sha256 "7e86b6f82b7951c3e81cea75f79baf7a8a0f884fcb024f02a6153a467a3de1aa"
  head "https://invent.kde.org/frameworks/sonnet.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "hunspell"
  depends_on "libvoikko"
  depends_on "qt@6"

  depends_on "aspell" => :optional
  depends_on "hspell" => :optional

  def install
    system "cmake", *kde_cmake_args
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
    (testpath/"CMakeLists.txt").write("find_package(KF6Sonnet REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
