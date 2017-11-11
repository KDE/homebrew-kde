require "formula"

class Kf5Kservice < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kservice-5.40.0.tar.xz"
  sha256 "ecc3fff3b75e8c4ef035e7f7d9f2b3ebe534d7576a0475c4c29174c3ef3fed36"
  desc "Advanced plugin and service introspection"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kservice.git"

  depends_on "cmake" => :build
  # The bison 2.3 in Mac OS X is too old to build. Use homebrew's instead
  depends_on "bison" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kcrash"
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
