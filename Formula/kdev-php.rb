require_relative "../lib/cmake"

class KdevPhp < Formula
  desc "PHP Language Plugin for KDevelop"
  homepage "https://kde.org/applications/development/org.kde.kdev-php"
  url "https://download.kde.org/stable/release-service/21.12.3/src/kdev-php-21.12.3.tar.xz"
  version "21.13.12.3"
  sha256 "4a85438a51bf6e3faedca3f64c2ffd08355d20fd4214c12fe010f003f5c3b17c"
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
