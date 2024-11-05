require_relative "../lib/cmake"

class Kded < Formula
  desc "Extensible deamon for providing system level services"
  homepage "https://api.kde.org/frameworks/kded/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kded-6.7.0.tar.xz"
  sha256 "22aa1b6543b40e094346138516131c0f7eb78a70e87296938457fd1386680a2f"
  head "https://invent.kde.org/frameworks/kded.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kconfig"
  depends_on "kde-mac/kde/kcoreaddons"
  depends_on "kde-mac/kde/kcrash"
  depends_on "kde-mac/kde/kdbusaddons"
  depends_on "kde-mac/kde/kservice"
  depends_on "qt@6"

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
