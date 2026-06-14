require_relative "../lib/cmake"

class Kolourpaint < Formula
  desc "Paint Program"
  homepage "https://kde.org/applications/graphics/kolourpaint/"
  url "https://download.kde.org/stable/release-service/23.08.2/src/kolourpaint-23.08.2.tar.xz"
  sha256 "0eb9d2acbefb4d764adbe686117b63ddb565d680906375264af78a4a14931cbb"
  head "https://invent.kde.org/graphics/kolourpaint.git", branch: "master"

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "kde-mac/kde/kf5-kdesignerplugin" => :build
  depends_on "kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "kde-mac/kde/kf5-kdelibs4support"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kolourpaint.app/Contents/Info.plist"
  end

  post_install_steps do
    mkdir_p "share/kolourpaint", base: :homebrew_prefix
    ln_sf "share/icons/breeze/breeze-icons.rcc", "share/kolourpaint/icontheme.rcc", source_base: :homebrew_prefix,
                                                                                    target_base: :homebrew_prefix
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kolourpaint.app/Contents/MacOS/kolourpaint --help")
  end
end
