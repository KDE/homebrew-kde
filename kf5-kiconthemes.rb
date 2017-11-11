require "formula"

class Kf5Kiconthemes < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kiconthemes-5.40.0.tar.xz"
  sha256 "7d83b48411ebc177f8b998050b9d5ffd612c763275f1121a2470dded4a97de44"
  desc "Support for icon themes"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kiconthemes.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kitemviews"
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
