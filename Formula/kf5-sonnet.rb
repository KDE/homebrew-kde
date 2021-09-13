require_relative "../lib/cmake"

class Kf5Sonnet < Formula
  desc "Spelling framework for Qt5"
  homepage "https://api.kde.org/frameworks/sonnet/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.86/sonnet-5.86.0.tar.xz"
  sha256 "12fcb1bab11cde11b14eb20a415bc5112170f68e90ca05a36885b8b05a16a367"
  head "https://invent.kde.org/frameworks/sonnet.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
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
