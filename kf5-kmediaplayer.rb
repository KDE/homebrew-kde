require "formula"

class Kf5Kmediaplayer < Formula
  url "http://download.kde.org/stable/frameworks/5.40/portingAids/kmediaplayer-5.40.0.tar.xz"
  sha256 "f44e170996411fcde7a63fd847631a4b8ed45d7098a56a26b866b3fd0d9bfe8e"
  desc "Plugin interface for media player features"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/attica.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kparts"
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
