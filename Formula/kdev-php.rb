require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/release-service/21.12.0/src/kdev-php-21.12.0.tar.xz"
  sha256 "ff94674413f4f1eec4c631675e413bc733565934eb65e44998fbc2b6ba09410b"
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
