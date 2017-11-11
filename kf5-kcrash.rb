require "formula"

class Kf5Kcrash < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kcrash-5.40.0.tar.xz"
  sha256 "96d2b2d16317519f95fa9277beca9d4a10f65dac608bfa0783a5823efe0f0406"
  desc "Support for application crash analysis and bug report from apps"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kcrash.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "qt"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
