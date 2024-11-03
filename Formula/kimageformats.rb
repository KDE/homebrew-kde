require_relative "../lib/cmake"

class Kimageformats < Formula
  desc "Image format plugins for Qt6"
  homepage "https://api.kde.org/frameworks/kimageformats/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kimageformats-6.7.0.tar.xz"
  sha256 "722850648ac167e4c0ee631571fde49e9fd15d004a127dd804a14f9f579b731f"
  head "https://invent.kde.org/frameworks/kimageformats.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "jasper"
  depends_on "karchive"
  depends_on "openexr"
  depends_on "qt@6"

  def install
    system "cmake", *kde_cmake_args
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
    assert_predicate lib/"qt6/plugins/imageformats/kimg_eps.so", :exist?
    assert_predicate share/"kservices6/qimageioplugins/eps.desktop", :exist?
  end
end
