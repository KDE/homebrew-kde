require_relative "../lib/cmake"

class Kpeople < Formula
  desc "Provides access to all contacts and the people"
  homepage "https://api.kde.org/frameworks/kpeople/html/index.html"
  url "https://download.kde.org/stable/frameworks/6.7/kpeople-6.7.0.tar.xz"
  sha256 "d36246bac50f5bf406f683fe61c92cb5e623a51de9ffed1104665e5f135ef888"
  head "https://invent.kde.org/frameworks/kpeople.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kcoreaddons"
  depends_on "kde-mac/kde/kitemviews"
  depends_on "ki18n"
  depends_on "kde-mac/kde/kcontacts"
  depends_on "kde-mac/kde/kwidgetsaddons"

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
