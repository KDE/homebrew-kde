require_relative "../lib/cmake"

class Kf5Kcoreaddons < Formula
  desc "Qt addon library with a collection of non-GUI utilities"
  homepage "https://api.kde.org/frameworks/kcoreaddons/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.94/kcoreaddons-5.94.0.tar.xz"
  sha256 "5c10b6ce070d6aa9b15abe7483b67f8802cec175e0eaeefc18a27c0e01ce110b"
  head "https://invent.kde.org/frameworks/kcoreaddons.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "doxygen" => :build
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "graphviz" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "qt@5"

  def install
    args = kde_cmake_args

    args << "-DUPDATE_MIME_DATABASE_EXECUTABLE=OFF"

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5CoreAddons REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
