require_relative "../lib/cmake"

class Kf5Kded < Formula
  desc "Extensible deamon for providing system level services"
  homepage "https://api.kde.org/frameworks/kded/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.99/kded-5.99.0.tar.xz"
  sha256 "02c1d8354dbf4e3f47a8ae9d8bdbd1c7942d46acd966bdd7d73fd971834870cd"
  head "https://invent.kde.org/frameworks/kded.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kinit"

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
    (testpath/"CMakeLists.txt").write("find_package(KDED REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
