require_relative "../lib/cmake"

class Tellico < Formula
  desc "KDE collections manager"
  homepage "https://tellico-project.org"
  url "https://tellico-project.org/files/tellico-3.4.1.tar.xz"
  sha256 "f8514deac3b49af95a81ef096b3caba8d664e289de8f3d5724f88e2b78278561"
  head "https://invent.kde.org/office/tellico.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => [:build]
  depends_on "extra-cmake-modules" => [:build]
  depends_on "kdoctools" => [:build]
  depends_on "ninja" => [:build]

  depends_on "gettext"
  depends_on "karchive"
  depends_on "kde-mac/kde/kf5-breeze-icons"
  depends_on "kde-mac/kde/kf5-kcodecs"
  depends_on "kde-mac/kde/kf5-kcompletion"
  depends_on "kde-mac/kde/kf5-kconfig"
  depends_on "kde-mac/kde/kf5-kconfigwidgets"
  depends_on "kde-mac/kde/kf5-kcoreaddons"
  depends_on "kde-mac/kde/kf5-kcrash"
  depends_on "kde-mac/kde/kf5-kfilemetadata"
  depends_on "kde-mac/kde/kf5-kguiaddons"
  depends_on "kde-mac/kde/kf5-kiconthemes"
  depends_on "kde-mac/kde/kf5-kio"
  depends_on "kde-mac/kde/kf5-kitemmodels"
  depends_on "kde-mac/kde/kf5-kjobwidgets"
  depends_on "kde-mac/kde/kf5-knewstuff"
  depends_on "kde-mac/kde/kf5-kparts"
  depends_on "kde-mac/kde/kf5-kservice"
  depends_on "kde-mac/kde/kf5-ktextwidgets"
  depends_on "kde-mac/kde/kf5-kwallet"
  depends_on "kde-mac/kde/kf5-kwidgetsaddons"
  depends_on "kde-mac/kde/kf5-kwindowsystem"
  depends_on "kde-mac/kde/kf5-kxmlgui"
  depends_on "kde-mac/kde/kf5-solid"
  depends_on "kde-mac/kde/kf5-sonnet"
  depends_on "ki18n"
  depends_on "libcdio"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "poppler"
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
end
