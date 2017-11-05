class Kf5Tier2Frameworks < Formula
  desc "Metapackage for Tier 2 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  url "https://sl1pkn07.wtf/paste/view/raw/f4513d60"
  sha256 "54d626e08c1c802b305dad30b7e54a82f102390cc92c7d4db112048935236e9c"

  depends_on "KDE-mac/kde/kf5-kactivities" => :build
  depends_on "KDE-mac/kde/kf5-kauth" => :build
  depends_on "KDE-mac/kde/kf5-kcompletion" => :build
  depends_on "KDE-mac/kde/kf5-kcrash" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "KDE-mac/kde/kf5-kfilemetadata" => :build
  depends_on "KDE-mac/kde/kf5-kimageformats" => :build
  depends_on "KDE-mac/kde/kf5-kjobwidgets" => :build
  depends_on "KDE-mac/kde/kf5-knotifications" => :build
  depends_on "KDE-mac/kde/kf5-kpackage" => :build
  depends_on "KDE-mac/kde/kf5-kdbusaddons" => :build
  depends_on "KDE-mac/kde/kf5-kpty" => :build # the page say is not ready for macos, but build ok (?)
  depends_on "KDE-mac/kde/kf5-kunitconversion" => :build
 
  def install
    FileUtils.touch "empty"
    prefix.install "empty"
  end
end

