require_relative "../lib/cmake"

class Kf5Kimageformats < Formula
  desc "Image format plugins for Qt5"
  homepage "https://api.kde.org/frameworks/kimageformats/html/index.html"
  revision 1
  head "https://invent.kde.org/frameworks/kimageformats.git"

  stable do
    url "https://download.kde.org/stable/frameworks/5.84/kimageformats-5.84.0.tar.xz"
    sha256 "badd15c93c1af2c6ab7f156245186a2223a184523070c6614328486e186eedf7"

    patch do # should be removed in 5.85.0
      url "https://invent.kde.org/frameworks/kimageformats/-/commit/5aa03c12add871996aaa865adf32554e4174ed06.diff"
      sha256 "2ceb47d4f5aaa9c0be75b061fc39e101f819c611a72b4e9b2f83732b5a342331"
    end
  end

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "jasper"
  depends_on "karchive"
  depends_on "openexr"
  depends_on "qt@5"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_predicate lib/"qt5/plugins/imageformats/kimg_eps.so", :exist?
    assert_predicate share/"kservices5/qimageioplugins/eps.desktop", :exist?
  end
end
