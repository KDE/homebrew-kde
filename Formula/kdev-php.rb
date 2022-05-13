require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/release-service/22.04.1/src/kdev-php-22.04.1.tar.xz"
  sha256 "5e40d2412accda564b56710eea25c165c776b0146449b1d79b45751c97ffbbb3"
  head "https://invent.kde.org/kdevelop/kdev-php.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "kdevelop"

  def install
    args = kde_cmake_args
    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end
end
