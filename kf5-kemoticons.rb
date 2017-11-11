require "formula"

class Kf5Kemoticons < Formula
  url "http://download.kde.org/stable/frameworks/5.40/kemoticons-5.40.0.tar.xz"
  sha256 "4c104050697b82418b303b004a635652793d6fc6b2c8745c948110b9f07611cb"
  desc "Support for emoticons and emoticons themes"
  homepage "http://www.kde.org/"

  head "git://anongit.kde.org/kemoticons.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kservice"
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
