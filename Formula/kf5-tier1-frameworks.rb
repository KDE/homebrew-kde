class Kf5Tier1Frameworks < Formula
  desc "Metapackage for Tier 1 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  system "touch", "/tmp/empty"
  url "file:///tmp/empty"
  version "5.52.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "KDE-mac/kde/kf5-attica" => :build
  depends_on "KDE-mac/kde/kf5-breeze-icons" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kapidox" => :build
  depends_on "KDE-mac/kde/kf5-karchive" => :build
  depends_on "KDE-mac/kde/kf5-kcodecs" => :build
  depends_on "KDE-mac/kde/kf5-kconfig" => :build
  depends_on "KDE-mac/kde/kf5-kcoreaddons" => :build
  depends_on "KDE-mac/kde/kf5-kdbusaddons" => :build
  depends_on "KDE-mac/kde/kf5-kdnssd" => :build
  depends_on "KDE-mac/kde/kf5-kguiaddons" => :build
  depends_on "KDE-mac/kde/kf5-ki18n" => :build
  depends_on "KDE-mac/kde/kf5-kidletime" => :build
  depends_on "KDE-mac/kde/kf5-kirigami2" => :build
  depends_on "KDE-mac/kde/kf5-kitemmodels" => :build
  depends_on "KDE-mac/kde/kf5-kitemviews" => :build
  depends_on "KDE-mac/kde/kf5-kplotting" => :build
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons" => :build
  depends_on "KDE-mac/kde/kf5-kwindowsystem" => :build
  depends_on "KDE-mac/kde/kf5-solid" => :build
  depends_on "KDE-mac/kde/kf5-sonnet" => :build
  depends_on "KDE-mac/kde/kf5-syntax-highlighting" => :build
  depends_on "KDE-mac/kde/kf5-threadweaver" => :build

  def install
    touch "empty"
    prefix.install "empty"
  end
end
