require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/release-service/22.08.3/src/kdev-php-22.08.3.tar.xz"
  sha256 "b727e89b7d9c421d100017190c8172d360667a2dfaa9de32699ca5667f8839c1"
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
