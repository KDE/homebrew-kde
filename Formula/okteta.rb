require_relative "../lib/cmake"

class Okteta < Formula
  desc "KDE hex editor for viewing and editing the raw data of files"
  homepage "https://apps.kde.org/okteta"
  url "https://download.kde.org/stable/okteta/0.26.18/src/okteta-0.26.18.tar.xz"
  sha256 "c4096166d42e211b6f31a1df942afcf651c7ea872a2110040b01dd45afbf8a63"
  head "https://invent.kde.org/utilities/okteta.git", branch: "master"

  livecheck do
    url "https://download.kde.org/stable/okteta/"
    regex(/href=["']?(\d+(?:\.\d+)+)/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "hicolor-icon-theme"
  depends_on "kde-mac/kde/breeze-icons"
  depends_on "kde-mac/kde/kcmutils"
  depends_on "kde-mac/kde/knewstuff"
  depends_on "kde-mac/kde/kparts"
  depends_on "qca"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@6"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\"",
      "#{bin}/okteta.app/Contents/Info.plist"
  end

  def post_install
    mkdir_p HOMEBREW_PREFIX/"share/okteta"
    ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/okteta/icontheme.rcc"
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/okteta.app/Contents/MacOS/okteta --help")
  end
end
