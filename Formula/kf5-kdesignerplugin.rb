require_relative "../lib/cmake"

class Kf5Kdesignerplugin < Formula
  desc "Integration of Frameworks widgets in Qt Designer/Creator"
  homepage "https://api.kde.org/frameworks/kdesignerplugin/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.115/portingAids/kdesignerplugin-5.115.0.tar.xz"
  sha256 "a0ec6e43bdd3c9823638a4454f5cb9afc5bdc165c93ba00899cf8e683e47e8e8"
  head "https://invent.kde.org/frameworks/kdesignerplugin.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "gettext" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kplotting"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5DesignerPlugin REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
