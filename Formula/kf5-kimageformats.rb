require_relative "../lib/cmake"

class Kf5Kimageformats < Formula
  desc "Image format plugins for Qt5"
  homepage "https://api.kde.org/frameworks/kimageformats/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.93/kimageformats-5.93.0.tar.xz"
  sha256 "15b0ed9de57af95979e0e40496b980f243cd81e2a400d5f64d12478e1dddc7d0"
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
