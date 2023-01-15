require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/release-service/22.12.1/src/kdev-php-22.12.1.tar.xz"
  sha256 "00f6b91e73d7c6900e4c4975bf174cb72e03c55f6bc72884e92947c2d22aca4a"
  head "https://invent.kde.org/kdevelop/kdev-php.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "kdevelop"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
end
