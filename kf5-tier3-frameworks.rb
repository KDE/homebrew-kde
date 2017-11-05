class Kf5Tier3Frameworks < Formula
  desc "Metapackage for Tier 3 KF5 frameworks"
  homepage "https://api.kde.org/frameworks"
  url "https://sl1pkn07.wtf/paste/view/raw/f4513d60"
  sha256 "54d626e08c1c802b305dad30b7e54a82f102390cc92c7d4db112048935236e9c"

  depends_on "KDE-mac/kde/kf5-kbookmarks"
  depends_on "KDE-mac/kde/kf5-kcmutils"
  depends_on "KDE-mac/kde/kf5-kconfigwidgets"
  depends_on "KDE-mac/kde/kf5-kdeclarative"
  depends_on "KDE-mac/kde/kf5-kded"
  depends_on "KDE-mac/kde/kf5-kdesignerplugin"
  depends_on "KDE-mac/kde/kf5-kdesu"
#  depends_on "KDE-mac/kde/kf5-kdewebkit" # Fail build due missing qt-webkit package
  depends_on "KDE-mac/kde/kf5-kemoticons"
  depends_on "KDE-mac/kde/kf5-kglobalaccel"
  depends_on "KDE-mac/kde/kf5-kiconthemes"
  depends_on "KDE-mac/kde/kf5-kinit"
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-kparts"
  depends_on "KDE-mac/kde/kf5-kpeople"
  #depends_on "KDE-mac/kde/kf5-krunner"
  depends_on "KDE-mac/kde/kf5-kservice"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-ktextwidgets"
  depends_on "KDE-mac/kde/kf5-kwallet"
  depends_on "KDE-mac/kde/kf5-kxmlgui"
  #depends_on "KDE-mac/kde/kf5-kxmlrpcclient"
  #depends_on "KDE-mac/kde/kf5-plasma"

  def install
    FileUtils.touch "empty"
    prefix.install "empty"
  end
end

