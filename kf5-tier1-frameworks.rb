class Kf5Tier1Frameworks < Formula
  desc "Metapackage for Tier 1 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  url "https://sl1pkn07.wtf/paste/view/raw/f4513d60"
  sha256 "54d626e08c1c802b305dad30b7e54a82f102390cc92c7d4db112048935236e9c"

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
  depends_on "KDE-mac/kde/kf5-syntax-highlighting" => :build
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons" => :build
  depends_on "KDE-mac/kde/kf5-kwindowsystem" => :build
  #depends_on "KDE-mac/kde/kf5-qqc2-desktop-style" => :build
  depends_on "KDE-mac/kde/kf5-solid" => :build
  depends_on "KDE-mac/kde/kf5-sonnet" => :build
  depends_on "KDE-mac/kde/kf5-threadweaver" => :build

  def install
    FileUtils.touch "empty"
    prefix.install "empty"
  end
end

