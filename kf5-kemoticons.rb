require "formula"

class Kf5Kemoticons < Formula
  desc "Support for emoticons and emoticons themes"
  homepage "http://www.kde.org/"
  url "https://download.kde.org/stable/frameworks/5.39/kemoticons-5.39.0.tar.xz"
  sha256 "f05d4812ae8472fc455be7bb6b8e5f45ffef17b415b7154f08ba0eb293d14f8c"

  head "git://anongit.kde.org/kemoticons.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "qt"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kservice"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
