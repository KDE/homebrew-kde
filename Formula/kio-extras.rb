require_relative "../lib/cmake"

class KioExtras < Formula
  desc "Additional components to increase the functionality of KIO"
  homepage "https://www.kde.org/applications/internet/"
  url "https://download.kde.org/stable/release-service/22.12.1/src/kio-extras-22.12.1.tar.xz"
  sha256 "fb81d655c97942321888f215c74d07346fc9a0364fd7414ffdf227ff20d2313c"
  head "https://invent.kde.org/network/kio-extras.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gperf" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "exiv2"
  depends_on "kde-mac/kde/kf5-kdnssd"
  depends_on "kde-mac/kde/kf5-kimageformats"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kpty"
  depends_on "kde-mac/kde/kf5-syntax-highlighting"
  depends_on "libmtp"
  depends_on "openexr"

  # Requires x86_64 macOS
  depends_on "openslp" if OS.mac? && Hardware::CPU.intel?
  depends_on "taglib"

  patch do
    # Fix https://bugs.kde.org/show_bug.cgi?id=402335
    url "https://bugsfiles.kde.org/attachment.cgi?id=117165"
    sha256 "bce9033737ef90b038fa5521f0b9b5e192b8ae27a4fedc96eda76ac8f7943315"
  end

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
    (testpath/"CMakeLists.txt").write("find_package(KF5KioArchive REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
