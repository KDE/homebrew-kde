require_relative "../lib/cmake"

class Tellico < Formula
  desc "KDE collections manager"
  homepage "https://tellico-project.org"
  url "https://tellico-project.org/files/tellico-3.4.4.tar.xz"
  sha256 "8054292a76e553aaa9ed3f73da8fc35fef0841e3fe139e99c372925f9715d7c1"
  head "https://invent.kde.org/office/tellico.git", branch: "master"

  depends_on "cmake" => [:build]
  depends_on "extra-cmake-modules" => [:build]
  depends_on "kdoctools" => [:build]
  depends_on "ninja" => [:build]

  depends_on "exempi"
  depends_on "hicolor-icon-theme"
  depends_on "kde-mac/kde/kf5-kfilemetadata"
  # qt@5 is built without WebEngine on arm64 macOS
  depends_on "kde-mac/kde/kf5-khtml" if OS.mac? && Hardware::CPU.arm?
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kitemmodels"
  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/kf5-kxmlgui"
  depends_on "kde-mac/kde/kf5-solid"
  depends_on "libcdio"
  depends_on "perl"
  depends_on "poppler-qt5"
  depends_on "python@3.9"
  depends_on "qt@5"
  depends_on "taglib"
  depends_on "yaz"

  def install
    args = kde_cmake_args

    system "cmake", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\:#{HOMEBREW_PREFIX}/lib/qt5/plugins\"",
      "#{bin}/tellico.app/Contents/Info.plist"
  end

  test do
    assert_match "help", shell_output("#{bin}/tellico.app/Contents/MacOS/tellico --help")
  end
end
