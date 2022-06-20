require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/release-service/22.04.2/src/kdev-php-22.04.2.tar.xz"
  sha256 "25098b4c5f475bf9d52fbbc0e691dd780f1b01b6b9b92230c32823e03caff6e6"
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
