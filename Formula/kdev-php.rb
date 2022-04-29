require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/release-service/22.04.0/src/kdev-php-22.04.0.tar.xz"
  sha256 "be846cf516450e686432062ba41ce04061b9e4587e9d4e955321ab6f57f65502"
  head "https://invent.kde.org/kdevelop/kdev-php.git", branch: "master"

  livecheck do
    skip "Newer versions doesn't compile due to bug: https://bugs.kde.org/show_bug.cgi?id=448152"
  end

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
