require_relative "../lib/cmake"

class Kmymoney < Formula
  desc "Personal finance manager similar to MS-Money or Quicken"
  homepage "https://kmymoney.org"
  revision 3
  head "https://invent.kde.org/office/kmymoney.git"

  stable do
    url "https://download.kde.org/stable/kmymoney/5.1.1/src/kmymoney-5.1.1.tar.xz"
    sha256 "df7b9f78e8596f99d28295ca738708f0655ee057789dfd921c7b1bab96578298"
    depends_on "kde-mac/kde/kf5-kiconthemes"
  end

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build, :test]
  depends_on "extra-cmake-modules" => [:build, :test]
  depends_on "ninja" => :build
  depends_on "shared-mime-info" => :build

  depends_on "aqbanking"
  depends_on "boost"
  depends_on "gpgme"
  depends_on "kde-mac/kde/kdiagram"
  depends_on "kde-mac/kde/kf5-kactivities"
  depends_on "kde-mac/kde/kf5-kcmutils"
  depends_on "kde-mac/kde/kf5-kdewebkit"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kitemmodels"
  depends_on "kde-mac/kde/kf5-kross"
  depends_on "kde-mac/kde/libalkimia"
  depends_on "libical"
  depends_on "libofx"
  depends_on "sqlcipher"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/kmymoney.app/Contents/Info.plist"
  end

  def post_install
    system HOMEBREW_PREFIX/"bin/update-mime-database", HOMEBREW_PREFIX/"share/mime"

    if build.stable?
      mkdir_p HOMEBREW_PREFIX/"share/kmymoney"
      ln_sf HOMEBREW_PREFIX/"share/icons/breeze/breeze-icons.rcc", HOMEBREW_PREFIX/"share/kmymoney/icontheme.rcc"
    end
  end

  def caveats
    <<~EOS
      You need to take some manual steps in order to make this formula work:
        "$(brew --repo kde-mac/kde)/tools/do-caveats.sh"
    EOS
  end

  test do
    assert_match "help", shell_output("#{bin}/kmymoney.app/Contents/MacOS/kmymoney --help")
  end
end
