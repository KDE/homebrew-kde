require_relative "../lib/cmake"

class Kf6Sonnet < Formula
  desc "Spelling framework for Qt6"
  homepage "https://api.kde.org/frameworks/sonnet/html/index.html"
#  url "https://download.kde.org/stable/frameworks/6.5/sonnet-6.5.0.tar.xz"
#  sha256 "7e86b6f82b7951c3e81cea75f79baf7a8a0f884fcb024f02a6153a467a3de1aa"
  url "http://www.qiliang.net/kde/sonnet-6.5.0.tar.xz"
  sha256 "218842d26bf2563d49ca379fd1c92fb773bea3ee1afd635d1a84deccff2ee203"
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
