require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/kdevelop/5.6.2/src/kdev-php-5.6.2.tar.xz"
  sha256 "f1083daec2b8c752de1a0441d0f9f72274b1e2d29c723005ed78dcf8ba717e0c"
  head "https://invent.kde.org/kdevelop/kdev-php.git", branch: "master"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
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
