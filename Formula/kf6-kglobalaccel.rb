require_relative "../lib/cmake"

class Kf6Kglobalaccel < Formula
  desc "Add support for global workspace shortcuts"
  homepage "https://api.kde.org/frameworks/kglobalaccel/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kglobalaccel-6.5.0.tar.xz"
  sha256 "883a1cf48fc4b8ce22ab9f143b6bdd546ac30fbe29c90d4035fb2adf38a339a4"
  head "https://invent.kde.org/frameworks/kglobalaccel.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kconfig"
  depends_on "kde-mac/kde/kf6-kcrash"
  depends_on "kde-mac/kde/kf6-kdbusaddons"

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
    (testpath/"CMakeLists.txt").write("find_package(KF6GlobalAccel REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
