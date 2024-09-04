require_relative "../lib/cmake"

class Kf6Kded < Formula
  desc "Extensible deamon for providing system level services"
  homepage "https://api.kde.org/frameworks/kded/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kded-6.5.0.tar.xz"
  sha256 "292ca941acc69c443f47895ea784493b08fd573afe0f4e99f5f42b8a029954b0"
  head "https://invent.kde.org/frameworks/kded.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "qt@6"
  depends_on "kde-mac/kde/kf6-kconfig"
  depends_on "kde-mac/kde/kf6-kcoreaddons"
  depends_on "kde-mac/kde/kf6-kcrash"
  depends_on "kde-mac/kde/kf6-kdbusaddons"
  depends_on "kde-mac/kde/kf6-kdoctools"
  depends_on "kde-mac/kde/kf6-kservice"

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
