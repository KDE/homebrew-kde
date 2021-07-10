require_relative "../lib/cmake"

class Kf5Sonnet < Formula
  desc "Spelling framework for Qt5"
  homepage "https://api.kde.org/frameworks/sonnet/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.84/sonnet-5.84.0.tar.xz"
  sha256 "d85afa9fd7f5e19aef639f6e1cebedc92255f0dfb24bbf57a15c89b57288cb76"
  head "https://invent.kde.org/frameworks/sonnet.git"

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
