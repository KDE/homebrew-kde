require_relative "../lib/cmake"

class Kdiff3 < Formula
  desc "Utility for comparing and merging files and directories"
  homepage "https://apps.kde.org/kdiff3/"
  url "https://download.kde.org/stable/kdiff3/kdiff3-1.9.4.tar.xz"
  sha256 "a130712ceef074df691426909fc4a332b66f4c3f1490a548ab5bfb46316c385a"
  head "https://invent.kde.org/sdk/kdiff3.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "kde-mac/kde/kf5-kcoreaddons" => :build
  depends_on "kde-mac/kde/kf5-kcrash" => :build
  depends_on "kde-mac/kde/kf5-kiconthemes" => :build
  depends_on "kde-mac/kde/kf5-kparts" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    args << "-DMACOSX_BUNDLE_ICON_FILE=kdiff3.icns"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  test do
    assert_match "help", shell_output("#{bin}/kdiff3.app/Contents/MacOS/kdiff3 --help")
  end
end
