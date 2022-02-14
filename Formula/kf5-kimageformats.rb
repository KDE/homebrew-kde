require_relative "../lib/cmake"

class Kf5Kimageformats < Formula
  desc "Image format plugins for Qt5"
  homepage "https://api.kde.org/frameworks/kimageformats/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.92/kimageformats-5.92.0.tar.xz"
  sha256 "ce049989125a49dc9bf8d2a2f2f5a2fec79e25a6343087b024fefd0131eca369"
  head "https://invent.kde.org/frameworks/kimageformats.git", branch: "master"

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
