require_relative "../lib/cmake"

class Kf5Kdesignerplugin < Formula
  desc "Integration of Frameworks widgets in Qt Designer/Creator"
  homepage "https://api.kde.org/frameworks/kdesignerplugin/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/portingAids/kdesignerplugin-5.79.0.tar.xz"
  sha256 "56f043b6cb745f308831b80d6a7b9cb2548f69221394c17095a399aecdc9f8c9"
  head "https://invent.kde.org/frameworks/kdesignerplugin.git"

  depends_on "cmake" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "kde-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kplotting"

  depends_on "kde-mac/kde/kf5-kdewebkit" => :optional

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
    (testpath/"CMakeLists.txt").write("find_package(KF5DesignerPlugin REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
