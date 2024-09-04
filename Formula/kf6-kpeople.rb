require_relative "../lib/cmake"

class Kf6Kpeople < Formula
  desc "Provides access to all contacts and the people"
  homepage "https://api.kde.org/frameworks/kpeople/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.5/kpeople-6.5.0.tar.xz"
  sha256 "102cd7ad3260b0d10bd2ec0330c839826ea324c5cd86580163d8364d3370a6c2"
  head "https://invent.kde.org/frameworks/kpeople.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf6-kcoreaddons"
  depends_on "kde-mac/kde/kf6-kitemviews"
  depends_on "ki18n"
  depends_on "kde-mac/kde/kf6-kcontacts"
  depends_on "kde-mac/kde/kf6-kwidgetsaddons"

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
    (testpath/"CMakeLists.txt").write("find_package(KF6People REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
