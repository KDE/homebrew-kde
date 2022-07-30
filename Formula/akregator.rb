class Akregator < Formula
  desc "KDE Feed Reader"
  homepage "https://kontact.kde.org/components/akregator/"
  url "https://download.kde.org/stable/release-service/22.04.3/src/akregator-22.04.3.tar.xz"
  sha256 "2f5551c5ebfce6e43ee22d46891d2f44eecb76af38f3979775f1c470c408c722"
  head "https://invent.kde.org/pim/akregator.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/grantlee"
  depends_on "kde-mac/kde/kf5-knotifyconfig"
  depends_on "kde-mac/kde/kf5-kuserfeedback"
  depends_on "kde-mac/kde/kf5-libkleo"
  depends_on "kde-mac/kde/kontactinterface"
  depends_on "kdoctools"
  depends_on "qt@5"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "help", shell_output("#{bin}/akregator.app/Contents/MacOS/akregator --help")
  end
end
