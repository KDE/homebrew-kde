require_relative "../lib/cmake"

class Tellico < Formula
  desc "KDE collections manager"
  homepage "https://tellico-project.org"
  url "https://tellico-project.org/files/tellico-4.0.1.tar.xz"
  sha256 "c8945b9425ec09e8ee4e5eeab0f2618769e186026823677fe2cb4cf41a68cd24"
  head "https://invent.kde.org/office/tellico.git", branch: "master"

  depends_on "cmake" => [:build]
  depends_on "extra-cmake-modules" => [:build]
  depends_on "kdoctools" => [:build]
  depends_on "ninja" => [:build]

  depends_on "exempi"
  depends_on "hicolor-icon-theme"
  depends_on "kde-mac/kde/kf5-khtml"
  depends_on "kde-mac/kde/kfilemetadata"
  depends_on "kde-mac/kde/kio"
  depends_on "kde-mac/kde/kitemmodels"
  depends_on "kde-mac/kde/knewstuff"
  depends_on "kde-mac/kde/kxmlgui"
  depends_on "kde-mac/kde/solid"
  depends_on "libcdio"
  depends_on "poppler-qt5"
  depends_on "qt@5"
  depends_on "taglib"
  depends_on "yaz"

  uses_from_macos "perl"

  def install
    system "cmake", *kde_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    prefix.install "build/install_manifest.txt"
    # Extract Qt plugin path
    qtpp = `#{Formula["qt@5"].bin}/qtpaths --plugin-dir`.chomp
    system "/usr/libexec/PlistBuddy",
      "-c", "Add :LSEnvironment:QT_PLUGIN_PATH string \"#{qtpp}\"",
      "#{bin}/tellico.app/Contents/Info.plist"
  end

  test do
    assert_match "help", shell_output("#{bin}/tellico.app/Contents/MacOS/tellico --help")
  end
end
