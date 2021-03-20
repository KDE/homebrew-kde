require_relative "../lib/cmake"

class Kf5Kpackage < Formula
  desc "Lets applications manage user installable packages"
  homepage "https://api.kde.org/frameworks/kpackage/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.79/kpackage-5.79.0.tar.xz"
  sha256 "47782782f9cda0d38ab87be340b868cfb9350e3a53b4126d8ea2c33429e173f6"
  head "https://invent.kde.org/frameworks/kpackage.git"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "karchive"
  depends_on "ki18n"
  depends_on "kde-mac/kde/kf5-kcoreaddons"

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
    (testpath/"CMakeLists.txt").write("find_package(KF5Package REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
