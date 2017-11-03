class Kf5Tier1Frameworks < Formula
  desc "Metapackage for Tier 1 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  url "https://sl1pkn07.wtf/paste/view/raw/f4513d60"
  sha256 "54d626e08c1c802b305dad30b7e54a82f102390cc92c7d4db112048935236e9c"

  depends_on "KDE-mac/kde/kf5-attica"
  depends_on "KDE-mac/kde/kf5-breeze-icons"
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules"
  depends_on "KDE-mac/kde/kf5-kapidox"
  depends_on "KDE-mac/kde/kf5-karchive"
  depends_on "KDE-mac/kde/kf5-kcodecs"
  depends_on "KDE-mac/kde/kf5-kconfig"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-kdbusaddons"
  depends_on "KDE-mac/kde/kf5-kdnssd"
  depends_on "KDE-mac/kde/kf5-kguiaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"
  depends_on "KDE-mac/kde/kf5-kidletime"
  depends_on "KDE-mac/kde/kf5-kirigami2"
  depends_on "KDE-mac/kde/kf5-kitemmodels"
  depends_on "KDE-mac/kde/kf5-kitemviews"
  depends_on "KDE-mac/kde/kf5-kplotting"
  depends_on "KDE-mac/kde/kf5-syntax-highlighting"
  depends_on "KDE-mac/kde/kf5-kwidgetsaddons"
  depends_on "KDE-mac/kde/kf5-kwindowsystem"
  #depends_on "KDE-mac/kde/kf5-qqc2-desktop-style"
  depends_on "KDE-mac/kde/kf5-solid"
  depends_on "KDE-mac/kde/kf5-sonnet"
  depends_on "KDE-mac/kde/kf5-threadweaver"

  def install
    FileUtils.touch "empty"
    prefix.install "empty"
  end
end

