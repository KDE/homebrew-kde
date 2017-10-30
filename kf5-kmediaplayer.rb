require "formula"

class Kf5Kmediaplayer < Formula
  desc "Plugin interface for media player features"
  homepage "http://www.kde.org/"
  url "http://download.kde.org/stable/frameworks/5.39/portingAids/kmediaplayer-5.39.0.tar.xz"
  sha256 "e11e51541d4f70c4ba237fca37ae19a398f284e6ecef6cf0326292bc42e0da27"

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
