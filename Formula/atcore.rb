require_relative "../lib/cmake"

class Atcore < Formula
  desc "API to manage the connection to 3D Printers"
  homepage "https://atelier.kde.org/"
  url "https://download.kde.org/stable/atcore/1.0.0/atcore-1.0.0.tar.xz"
  sha256 "ffd12455c9b8db853e455a437d6c6b601e0003c6732bbc6c2828032e004530e2"
  revision 4
  head "https://invent.kde.org/libraries/atcore.git"

  depends_on "cmake" => [:build, :test]
  depends_on "kde-extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = kde_cmake_args
    args << "-DBUILD_GUI=ON" if build.head?

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"

    # move the plugins to real path
    mv "#{bin}/plugins", "#{bin}/AtCoreTest.app/Contents/MacOS/plugins"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/AtCoreTest.app/Contents/Info.plist"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(AtCore REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
